#!/bin/bash

cd /opt/aion

if [ -z "${network}" ]; then
	network=mastery
fi

export $network

#TODO: Mostly used for development purposes; remove miner setup after changing consensus
if [ -n $1 ]; then
	echo "Setting up miner..."
	# /bin/bash -c ./create-coinbase.sh
	chmod +x create-coinbase.sh
	/bin/bash -c ./create-coinbase.sh
else
	echo 'Skipping coinbase creation'
fi

echo "Overriding config parameters..."
python3 ./override-config.py

#TODO: Mostly used for development purposes
if [ ! -z "${difficulty}" ]; then
    echo "Overriding difficulty with ${difficulty}"
    sed 's/"difficulty": "0x4000"/"difficulty": "'${difficulty}'"/g' -i ./config/${network}/genesis.json
fi

#TODO: We wont's support setting options for the script as the container will have to be teared down after
#TODO: running and recreated again. This is not feasible in a production environment.Instead of passing options to the
#TODO: startup script we should provide a rpc/java API that will allow the required functionality to be present after
#TODO: kernel startup. Until then we can still use that functionality by manually starting a bash session in the
#TODO: container and running the commands that we need. Check DOCKER.md for more details.
echo "Starting kernel with network ${network}..."
./aion.sh -n $network
