#!/usr/bin/env bash

if [[ -n "$TRACE" ]]; then
    export PS4='[\D{%FT%TZ}] ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    set -o xtrace
fi
set -euo pipefail

IFS=$'\n\t'

DATE=`date +%H%M%S`

usage() {
cat <<EOF

Setup test instances and run tests for given image.

Note: This script assumes you have the triton cli command tool setup with a 
      provfile for your test environment.

This script will:

    - Create a test instance of the given image with user-script, user-data, 
      a public IP and private IP.
      - Create a custom image of the test instance.
      - Create a test instance from the custom image.
      - Run tests on the above instances .

    Usage:
    
        $0 -i <IMAGE> -p <Profile Name>
        
    Example:
    
        $0 -i a3c7b9ba-279d-11e6-aecd-07e1aa0cc545 -p us-east-3b
        
    Options:
    
        -i The image you want to test. Can be UUID or image name.
        -p The profile you wish to use. This assumes you have the triton
           CLI tool setup with your desired profile.
        -h Show this message

EOF
exit 1
}

IMAGE=
PROFILE=
PACKAGE=
IMAGENAME=
VERSION=
UUID=
NAME=
TAG="test-instance=true"
UUID=
SCRIPT=$PWD/userscript.sh
METADATAFILE="user-data=$PWD/user-data"

while getopts “hi:p:” OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    i)
      IMAGE=$OPTARG
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

if [[ -z $IMAGE ]] || [[ -z $PROFILE ]]; then
    usage
    exit 1
fi


get_image_details() {
    echo ""
    echo "Getting image details:"
    IMAGEDETAILS=$(triton -p ${PROFILE} image get $1 | json -a name version id)
    IMAGENAME=$(echo $IMAGEDETAILS | cut -d ' ' -f 1)
    VERSION=$(echo $IMAGEDETAILS | cut -d ' ' -f 2)
    UUID=$(echo $IMAGEDETAILS | cut -d ' ' -f 3)
    echo "    $IMAGEDETAILS"
    echo ""
}

set_name() {
    NAME="${IMAGENAME}-${VERSION}-${DATE}"
    echo "Instance name:"
    echo "    ${NAME}"
    echo ""
}

choose_package() {
    # Try a couple of package sizes, starting with 1GB
    PACKAGE=$(triton -p ${PROFILE} package list -H memory=1024 -o id | head -1)
    
    # Try 1.75GB package
    if [[ -z $PACKAGE ]]; then
        PACKAGE=$(triton -p ${PROFILE} package list -H memory=1792 -o id | head -1)
        exit 1
    fi
    echo "Using package:"
    echo "    $PACKAGE"
    echo ""
}

get_networks() {
	echo "Getting networks:"
    
    PUBLIC_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === true')
	PRIVATE_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === false' -c 'this.fabric !== true')
    
    # Trying using a fabric network instead
    if [[ -z "$PRIVATE_NETWORK" ]]; then
        PRIVATE_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === false')
    fi
    
    echo "    Public:  $PUBLIC_NETWORK"
    echo "    Private: $PRIVATE_NETWORK"
    echo ""
}

cat <<USERSCRIPT >userscript.sh
#!/bin/sh

echo "testing user-script" >> /var/tmp/test
hostname $IMAGENAME

USERSCRIPT

cat <<USERDATA >user-data
This is user-data!

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt 
in culpa qui officia deserunt mollit anim id est laborum.
USERDATA

create_instance() {
  echo "Provisioning:"
  triton -p ${PROFILE} instance create -w -n $NAME -N $PUBLIC_NETWORK -N $PRIVATE_NETWORK -t $TAG --script=$SCRIPT -M $METADATAFILE $1 $PACKAGE
}

cleanup() {
    echo "Cleaning up."
    
    rm -rf userscript.sh
    rm -rf user-data
    
    triton -p ${PROFILE} instance delete $NAME
    
    unset TARGET_HOST_NAME
    unset TARGET_USER_NAME
    echo ""
}

get_image_details $IMAGE
set_name
choose_package
get_networks
create_instance $IMAGE

cat <<PROPYML >properties.yml
$NAME:
  :roles:
    - common-lx
  :name: $NAME
PROPYML

sleep 1

TARGET_HOST_NAME=$(triton -p ${PROFILE} instance ip $NAME) TARGET_USER_NAME=root rake serverspec

echo "###########################"
echo "All common-lx tests PASSED."
echo "###########################"
echo ""

cleanup
exit 0
