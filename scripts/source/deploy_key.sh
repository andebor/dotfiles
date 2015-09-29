#Function to deploy rsa key to specified host
function deploy_key () {
	# check for argument
	if [ $# -eq 0 ]; then
    	echo "No host supplied"
    	exit 0
	fi
	#check if pub key exist. create if not
	if [[ ! -f $HOME/.ssh/id_rsa.pub ]]; then
		ssh-keygen -t rsa -C post@andersborud.com
	fi
	cat ~/.ssh/id_rsa.pub | ssh $USER@$1 " mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
	echo "Added rsa public key to authorized keys on $1."

}