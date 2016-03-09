#!/bin/bash
set -e
SETUP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COLOR_END='\e[0m'    # End of color
COLOR_RED='\e[0;31m' # Red
COLOR_YEL='\e[0;33m' # Yellow
COLOR_GRN='\e[0;32m' # green

## Print Error msg
##
msg_exit() {
  printf "> $COLOR_RED$@$COLOR_END\nExiting...\n" && exit 1
}

## Print MSG
##
msg_msg() {
  printf "| $COLOR_GRN$@$COLOR_END\n"
}

## Check if command exists
##
command_exists () {
    type "$1" &> /dev/null ;
}

if [ "$(id -u)" != "0" ]; then
   msg_exit "You need to run this script as root ${COLOR_GRN}sudo ${0}${COLOR_END}" 1>&2
fi


if ! command_exists gem ; then
   msg_exit " Ruby and Gems are required to run the tests."
fi

msg_msg " | Installing bundler"
gem install bundler --no-ri --no-rdoc
echo ""

msg_msg " | Installing gems"
bundler install
echo ""

# Run specs
msg_msg " | Running the tests "
cd ${SETUP_DIR}
bundle exec rspec
echo ""
