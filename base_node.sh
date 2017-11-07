#!/bin/bash

GENESIS="PrivateGenesis.json"
GETH_PATH="/usr/local/"
BOOT_NODE="enode://28746f833f00d1ee0a75653892f8353e74eb9723978225622f459dd60f6b0cd7c1782028378810b7b6f2e8366ca4edb32389c74cdc94b539b1e1513ee1416831@127.0.0.1:30301"
NETWORKID="7131208"

startGethNodeWithRPCBackEnd () {
  if [ ! -z "$3" ]
  then
    echo "Starting [Node $1] with RPC backend and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --nodiscover --port $1 --rpc --rpcapi 'web3,eth,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --unlock $3 --password $4 --preload "utils.js" console
  else
    echo "Starting [Node $1] with RPC backend"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --nodiscover --port $1 --rpc --rpcapi 'web3,eth,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --preload "utils.js" console
  fi
}

startGethNodeWithoutRPCBackEnd () {
  if [ ! -z "$3" ]
  then
    echo "Starting [Node $1] and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --datadir $2 --bootnodes $BOOT_NODE --unlock $3 --password $4 --preload "utils.js" console
  else
    echo "Starting [Node $1]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid $NETWORKID --port $1 --datadir $2 --bootnodes $BOOT_NODE --preload "utils.js" console
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
  bootnode --nodekey=run/boot.key
}