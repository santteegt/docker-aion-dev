#!/bin/bash

if [ ! -d ./jdk-10.0.1 ]; then
	echo 'Downloading JDK-10'
	wget -O jdk.tar.gz https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz
	tar -xf jdk.tar.gz
	# rm -f jdk.tar.gz
fi

if [ -d ./aion ]; then
	echo 'Copying packed aion impl'
	if [ ! -d ./aion/pack ]; then
		echo 'Packed impl not found. You MUST compile the AION project first!'
		exit 1
	fi
	if [ ! -d ./docker/aoin ]; then
		echo 'Extracting AION impl'
		cp ./aion/pack/aion.tar.bz2 ./docker
		cd docker/
		tar -xf aion.tar.bz2
		rm -f aion.tar.bz2
		cd ..
	else
		echo 'Compiled AION instance already exists in folder'
	fi
	echo 'Copying exec files...'

	cp docker/aion-docker.sh ./docker/aion/aion-docker.sh
	cp docker/create-coinbase.sh ./docker/aion/create-coinbase.sh
	cp docker/override-config.py ./docker/aion/override-config.py

	cp jdk-10.0.1/lib/libjdwp.so ./docker/aion/rt/lib/.
	cp jdk-10.0.1/lib/libdt_socket.so ./docker/aion/rt/lib/.

	echo 'Configuration finished'
else
	echo 'AION project NOT FOUND. Clone it first'
fi