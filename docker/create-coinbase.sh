#!/bin/bash

echo 'Network to use: '${network}

if [ ! -z "$coinbase_password" ]; then
    yes "$coinbase_password" | JAVA_OPTS="" ./aion.sh -a create -n ${network}
    coinbase_address=$(JAVA_OPTS="" ./aion.sh -a list -n ${network} | tail -n 1 | awk '{$1=$1};1')
    miner_address=$coinbase_address python3 override-config.py
fi
