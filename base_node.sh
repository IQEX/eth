#!/bin/bash

GENESIS="PrivateGenesis.json"
GETH_PATH="/usr/local/"
BOOT_NODE="enode://65aab27bfc3563c13e1ad661ab5336557c1aa7b303bce4b2d9cd946faac8d290c82e5c75ab44dbc41453697a5904f73cdd14f391a54d26698b6b62242c7c893f@127.0.0.1:30301"
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
    bootnode --genkey=run/boot.key
  fi
  bootnode --nodekey=run/boot.key --verbosity=9
}
