#! /bin/bash

# Tiny script do deploy ssh-keys to multiple hosts. Loops through an array of environment variables declared in zshrc/bashrc. Creates key if not found. Gives user multiple password prompts.

HOSTS="$ROCKY $RAMBO $MACGYVER $STUD"
EMAIL="post@$RAMBO"

echo "This script will deploy your ssh-key to the following hosts:"
for host in $HOSTS; do
	echo "- $host" 
done

read -p "Do you want to procede? (y/n)" -n 1 response </dev/tty
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo ""
    echo "Exiting..."
    exit 0
fi
echo ""
if [[ ! -f $HOME/.ssh/id_rsa.pub ]]; then
	ssh-keygen -t rsa -C $EMAIL
fi

for host in $HOSTS; do
	cat ~/.ssh/id_rsa.pub | ssh andebor@$host " cat >> ~/.ssh/authorized_keys"
done
