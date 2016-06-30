#!/bin/bash

function makeenv() {
    # get directory name only
    DIRNAME=${PWD##*/}
    # Get working directory
    WORKINGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    
    #Check shell for to determine read syntax
    if [[ "$SHELL" == "/bin/zsh" ]]; then
      if [[ $# -eq 1 ]];then
        read -q "response?Do you want to create a python2.7 virtualenv inside this directory($WORKINGDIR)? (y/n)"
      else
        read -q "response?Do you want to create a python3 virtualenv inside this directory($WORKINGDIR)? (y/n)"
      fi
    else
      if [[ $# -eq 1 ]];then
        read -p "Do you want to create a python2.7 virtualenv inside this directory($WORKINGDIR)? (y/n)" -n 1 response
      else
        read -p "Do you want to create a python3 virtualenv inside this directory($WORKINGDIR)? (y/n)" -n 1 response
      fi
    fi

    echo ""

    if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborting..."
        return
    fi
    #make enviroment
    # ENVNAME="env_$DIRNAME"
    # virtualenv $ENVNAME
    if [[ $1 -eq 2 ]];then
      virtualenv -p python "env_$DIRNAME"
    elif [[ $1 -eq 3 ]];then
      virtualenv -p python3 "env_$DIRNAME"
    else
      virtualenv -p python3 "env_$DIRNAME"
    fi

    # make .env file for autoenv
    echo "Creating .env file for autoenv.."
    echo "source $WORKINGDIR/env_$DIRNAME/bin/activate" > .env

    #activate new environment
    echo "Activating new environment.."
    source $WORKINGDIR/env_$DIRNAME/bin/activate
}
