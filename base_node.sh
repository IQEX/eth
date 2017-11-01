#!/bin/bash

GENESIS="/Users/ocsy/Workspaces/s5540liop/research/blockchain/PrivateGenesis.json"
GETH_PATH="/Users/ocsy/Workspaces/s5540liop/research/go-ethereum/build"
BOOT_NODE="enode://b7ff6d6bb79c0615ea4c8850bb50b22b13336b92ee27baf7ec2cae7e3eea0ace9fe3c1186a13cdf41964566c4dfa35e6e2a8ac39b6def80eb127aac5535d629c@127.0.0.1:30301"


startGethNodeWithRPCBackEnd () {
  if [ -z "$3" ]
  then
    echo "Starting [Node $1] with RPC backend and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid 208 --port $1 --rpc --rpcapi 'web3,eth,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --unlock $3 --password $4 --preload "help.js" console
  else
    echo "Starting [Node $1] with RPC backend"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid 208 --port $1 --rpc --rpcapi 'web3,eth,debug' --rpccorsdomain "*" --datadir $2 --bootnodes $BOOT_NODE --preload "help.js" console
  fi
}

startGethNodeWithoutRPCBackEnd () {
  if [ -z "$3" ]
  then
    echo "Starting [Node $1] and unlock account [$3]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid 208 --port $1 --datadir $2 --bootnodes $BOOT_NODE --unlock $3 --password $4 --preload "help.js" console
  else
    echo "Starting [Node $1]"
    $GETH_PATH/bin/geth --identity "Node $1" --networkid 208 --port $1 --datadir $2 --bootnodes $BOOT_NODE --preload "help.js" console
  fi
}

initNode(){
  echo "Re-initialize Ethereum in [$1] by [$GENESIS]"
  $GETH_PATH/bin/geth --datadir $1 init $GENESIS
}