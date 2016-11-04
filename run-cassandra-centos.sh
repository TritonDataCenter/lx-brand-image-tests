#!/usr/bin/env bash

if [[ -n "$TRACE" ]]; then
    export PS4='[\D{%FT%TZ}] ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    set -o xtrace
fi
set -euo pipefail

IFS=$'\n\t'

#===============================================================================
# YCSB Parameters:
#
# Modify the following parameters based on how much you want to stress the Cassandra servers.
#
# RECORDCOUNT = The number of test records to be inserted into the Cassandra database at load time.
# OPERATIONCOUNT = The number of test records to be manipulated (i.e. read/insert/update/delete) at run time.
#    Set RECORDCOUNT and/or OPERATIONCOUNT to a higher number (as high as 10 millions) if you want to
#    perform more stress testing. RECORDCOUNT does not have to match OPERATIONCOUNT.
# THREADS = The number of test client threads to be run in parallel. Note: The maximum number of threads
#    may depend on the CPU and Memory of your YCSB container.

RECORDCOUNT=10000
OPERATIONCOUNT=10000
THREADS=10

#===============================================================================

IMAGE=
PACKAGE=
PROFILE=
IP1=
IP2=
DATE=`date +%H%M%S`

usage() {
cat <<EOF

Usage:
      $0 -i <IMAGE> -k <PACKAGE> -p <Profile Name>

Example:
      $0 -i centos-7 -k g4-general-16G -p us-east-3b

Options:
      -h Show this message
      -i The image you want to test. Can be UUID or image name.
      -k The package you want to use.  Can be UUID or package name.
      -p The profile you wish to use with Triton CLI.

This script will:
      - Create 3 instances, using the specified image and package.
      - NOTE: This test will work only for an lx image with CentOS.
      - Install Cassandra software, and configure a 2-node Cassandra cluster.
      - Install and configure the YCSB benchmark tool.
      - Execute the YCSB benchmark tests against the Cassandra cluster.
      - NOTE: This script assumes you have the Triton CLI command tool setup
        with a valid profile for your test environment.

EOF
exit 1
}

while getopts “hi:k:p:” OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    i)
      IMAGE=$OPTARG
      ;;
    k)
      PACKAGE=$OPTARG
      ;;
    p)
      PROFILE=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if [[ -z $IMAGE ]] || [[ -z $PACKAGE ]] || [[ -z $PROFILE ]]; then
    usage
    exit 1
fi

#--------------------------------------------------------------------
# Function definitions:
#

get_image_details() {
    echo "Getting image details:"
    IMAGEDETAILS=$(triton -p ${PROFILE} image get $1 | json -a name version id)
    IMAGENAME=$(echo $IMAGEDETAILS | cut -d ' ' -f 1)
    VERSION=$(echo $IMAGEDETAILS | cut -d ' ' -f 2)
    echo "    $IMAGEDETAILS"
    echo ""
}

get_package_details() {
    echo "Getting package details:"
    PACKAGEDETAILS=$(triton -p ${PROFILE} package get $1 | json -a name version id)
    echo "    $PACKAGEDETAILS"
    echo ""
}

set_name() {
    NAME="${IMAGENAME}-${VERSION}-${DATE}"
    echo "Instance name prefix:"
    echo "    ${NAME}"
    echo ""
}

create_instance() {
    echo "Creating instance ${1}:"
    triton -p ${PROFILE} instance create -w -n $1 $2 $3
}

cleanup() {
    echo "Cleaning up."
    unset TARGET_HOST_NAME
    unset TARGET_USER_NAME
    unset TEST
    unset NODE1
    unset NODE2
    unset RC
    unset OC
    unset TH
    triton -p ${PROFILE} instance delete $1 $2 $3
    echo ""
}

#--------------------------------------------------------------------
# Getting image and package info:
#

get_image_details $IMAGE
get_package_details $PACKAGE
set_name

#--------------------------------------------------------------------
# Test Set A1: Installing and configuring Cassandra on the first node
# (which is also the seed node)
#

create_instance ${NAME}_1 $IMAGE $PACKAGE
IP1=`triton -p ${PROFILE} instance ip ${NAME}_1`

rm -rf properties.yml
cat <<PROPYML >properties.yml
${NAME}_1:
  :roles:
    - cassandra-centos
  :name: ${NAME}_1
PROPYML

i=1
while [ $i -lt 6 ]; do
  if [[ -f properties.yml ]]; then
     break
  fi
  let i=i+1
  sleep 1
done

TARGET_HOST_NAME=${IP1} TARGET_USER_NAME=root TEST=A1 NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

#--------------------------------------------------------------------
# Test Set A2: Installing and configuring Cassandra on the second node
#

create_instance ${NAME}_2 $IMAGE $PACKAGE
IP2=`triton -p ${PROFILE} instance ip ${NAME}_2`

rm -rf properties.yml
cat <<PROPYML >properties.yml
${NAME}_2:
  :roles:
    - cassandra-centos
  :name: ${NAME}_2
PROPYML

i=1
while [ $i -lt 6 ]; do
  if [[ -f properties.yml ]]; then
     break
  fi
  let i=i+1
  sleep 1
done

TARGET_HOST_NAME=${IP2} TARGET_USER_NAME=root TEST=A2 NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

#--------------------------------------------------------------------
# Test Set B: Verifing that Cassandra cluster is running, and create keyspace
#

# Keep looping for about 30 seconds or until the "nodetool status" command returns an actual status.
i=1
while [ $i -lt 31 ]; do
  ssh root@$IP2 'nodetool status' > teststatus.out 2>&1 || true
  if [[ `grep $IP1 teststatus.out` ]]; then
     break
  fi
  let i=i+1
  sleep 1
done

TARGET_HOST_NAME=${IP2} TARGET_USER_NAME=root TEST=B NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

#--------------------------------------------------------------------
# Test Set C: Installing and configuring YCSB tool
#

create_instance ${NAME}_3 $IMAGE $PACKAGE
IP3=`triton -p ${PROFILE} instance ip ${NAME}_3`

rm -rf properties.yml
cat <<PROPYML >properties.yml
${NAME}_3:
  :roles:
    - cassandra-centos
  :name: ${NAME}_3
PROPYML

i=1
while [ $i -lt 6 ]; do
  if [[ -f properties.yml ]]; then
     break
  fi
  let i=i+1
  sleep 1
done

TARGET_HOST_NAME=${IP3} TARGET_USER_NAME=root TEST=C NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

#--------------------------------------------------------------------
# Test Set D: Loading the YCSB "workloada" test data
#

TARGET_HOST_NAME=${IP3} TARGET_USER_NAME=root TEST=D NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

# Keep looping for about 60 minutes or until there are some interesting contents in the test output file.
i=1
while [ $i -lt 721 ]; do
  ssh root@$IP3 'cat /opt/ycsb-0.11.0/LOG/workloada_load.out' > testload.out 2>&1 || true
  if [[ `grep "\[CLEANUP\], Operations" testload.out` ]]; then
     break
  fi
  let i=i+1
  sleep 5
done

echo "The following is output of YCSB load:"
echo ""
cat testload.out
echo ""

if [[ `grep "INSERT-FAILED" testload.out` ]]; then
  echo "###########################"
  echo "The YCSB Load tests FAILED!"
  echo "###########################"
  echo ""
  exit 1
fi

#--------------------------------------------------------------------
# Test Set E: Run the YCSB "workloada" benchmark tests
#

TARGET_HOST_NAME=${IP3} TARGET_USER_NAME=root TEST=E NODE1=${IP1} NODE2=${IP2} RC=${RECORDCOUNT} OC=${OPERATIONCOUNT} TH=${THREADS} rake serverspec

# Keep looping for about 60 minutes or until there are some interesting contents in the test output file.
i=1
while [ $i -lt 721 ]; do
  ssh root@$IP3 'cat /opt/ycsb-0.11.0/LOG/workloada_run.out' > testrun.out 2>&1 || true
  if [[ `grep "\[CLEANUP\], Operations" testrun.out` ]]; then
     break
  fi
  let i=i+1
  sleep 5
done

echo "The following is output of YCSB run:"
echo ""
cat testrun.out
echo ""

#--------------------------------------------------------------------
# If you get here, then all tests have passed.
#

echo "###########################"
echo "All tests PASSED."
echo "###########################"
echo ""

#--------------------------------------------------------------------
# Delete the instances.
#
cleanup ${NAME}_1 ${NAME}_2 ${NAME}_3
exit 0
