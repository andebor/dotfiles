#!/bin/bash

function makeenv() {
    # get directory name only
    DIRNAME=${PWD##*/}
    # Get working directory
    WORKINGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    
    #Check shell for to determine read syntax
    if [[ "$SHELL" == "/bin/zsh" ]]; then
        read -q "response?Do you want to create a virtualenv inside this directory($WORKINGDIR)? (y/n)"
    else
        read -p "Do you want to create a virtualenv inside this directory($WORKINGDIR)? (y/n)" -n 1 response
    fi

    echo ""

    if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborting..."
        return
    fi
    #make enviroment
    # ENVNAME="env_$DIRNAME"
    # virtualenv $ENVNAME
    virtualenv "env_$DIRNAME"

    # make .env file for autoenv
    echo "Creating .env file for autoenv.."
    echo "source $WORKINGDIR/env_$DIRNAME/bin/activate" > .env

    #activate new environment
    echo "Activating new environment.."
    source $WORKINGDIR/env_$DIRNAME/bin/activate
}
