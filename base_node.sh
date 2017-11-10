#!/bin/bash

GENESIS="PrivateGenesis.json"
GETH_PATH="/usr/local/"
BOOT_NODE="enode://5a4b439c086e6259a265d75e01a1a06f941d0dc89d554d11a04598c22da6a4786278460076e688127f8dfb3a95fa782082da1fbc16cedb6b57d6a76683152f92@192.168.4.109:30301"
NETWORKID="7131208"
VERBOSITY="4"
NETWORK="192.168.4.0/24"

startGethNodeWithRPCBackEnd () {
  if [ ! -z "$3" ]
  then
    echo "Starting [Node $1] with RPC backend and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --rpc --rpcapi 'web3,eth,personal,net,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --netrestrict $NETWORK --nat "none" --syncmode "full" --unlock $3 --password $4 --preload "utils.js" --verbosity $VERBOSITY console
  else
    echo "Starting [Node $1] with RPC backend"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --rpc --rpcapi 'web3,eth,personal,net,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --netrestrict $NETWORK --nat "none"--syncmode "full" --preload "utils.js" --verbosity $VERBOSITY console
  fi
}

startGethNodeWithoutRPCBackEnd () {
  if [ ! -z "$3" ]
  then
    echo "Starting [Node $1] and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --datadir $2 --bootnodes $BOOT_NODE --netrestrict $NETWORK --syncmode "full" --nat "none" --unlock $3 --password $4 --preload "utils.js" --verbosity $VERBOSITY console
  else
    echo "Starting [Node $1]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --datadir $2 --bootnodes $BOOT_NODE --netrestrict $NETWORK --syncmode "full" --nat "none" --preload "utils.js" --verbosity $VERBOSITY console
  fi
}

initNode(){
  echo "Re-initialize Ethereum in [$1] by [$GENESIS]"
  $GETH_PATH/bin/geth --datadir $1 init $GENESIS
}

createAccount() {
  echo "Creating account in [$1]. Use password: sol1234"
  $GETH_PATH/bin/geth --datadir $1 --nodiscover --maxpeers 0 account new
  echo "sol1234" > run/password
}

bootNode(){
  mkdir -p run
  if [ ! -e run/boot.key ]
  then
    bootnode --enkey=run/boot.key
  fi
  bootnode --nodekey=run/boot.key --verbosity=9
}
