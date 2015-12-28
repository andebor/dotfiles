#Function to deploy rsa key to specified host
function deploy_key () {
	# check for argument
	if [ $# -eq 0 ]; then
    	echo "No host supplied"
    	return 1
	fi
	#check if pub key exist. create if not
	if [[ ! -f $HOME/.ssh/id_rsa.pub ]]; then
		ssh-keygen -t rsa -C post@andersborud.com
	fi
	if cat ~/.ssh/id_rsa.pub | ssh $USER@$1 " mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"; then
			echo "Added rsa public key to authorized keys on $1."
	else
			echo "Something went wrong. See error message above."
	fi

}
