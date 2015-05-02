#! /bin/bash

# Tiny script do deploy ssh-keys to multiple hosts. Loops through an array of environment variables declared in zshrc/bashrc. Creates key if not found. Gives user multiple password prompts.

HOSTS=$(sed -n "/^export/p" $HOME/.host_variables | awk -F '[ =]' '{print $2}' | sed -r 's/[^ ]+/$&/g')
# This is based on me having a file that exports all the hosts as environmental variables in home dir.
# If you want a simpler solution, you can just do:
# HOSTS="example1.com example2.com example3.com"
EMAIL="post@$RAMBO"

echo "This script will deploy your ssh-key to the following hosts with username $USER:"
for host in $HOSTS; do
	eval echo "- $host" 
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
	cat ~/.ssh/id_rsa.pub | eval ssh $USER@$host " cat >> ~/.ssh/authorized_keys"
done