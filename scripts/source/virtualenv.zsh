#!/bin/bash

function makeenv() {
    # Get working directory
    WORKINGDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    
    #Check shell for to determine read syntax
    if [[ "$SHELL" == "/bin/zsh" ]]; then
        read -q "response?Do you want to make this directory($WORKINGDIR) a virtualenv? (y/n)"
    else
        read -p "Do you want to make this directory($WORKINGDIR) a virtualenv? (y/n)" -n 1 response
    fi

    echo ""

    if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborting..."
        echo $DIRNAME
        return
    fi
    #make enviroment
    virtualenv $WORKINGDIR

    # make .env file for autoenv
    echo "source $WORKINGDIR/bin/activate" > .env
}
