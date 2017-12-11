# Running Ethereum Dev network

Will run 3 nodes:

* Bootstrap node - used to sync date between nodes
* RPC node - node that exprots RPC interface (303)
* Mining node - node that does mining on order to execute Smart Contracts (PoW) (304)

## 1. Running Bootnode

* Start bootnode

`./bootnode.sh`

* Copy address starting with `enode://` and paste intro `base_node.sh`. Write `127.0.0.1` (or local node IP) instead of `[..]`

## 2. Creating main nodes

* Initing

`./init_node.sh run/nodes/node30303`
`./init_node.sh run/nodes/node30303`

* Creatring 303 node accout. Using `sol1234` as a pass

`./create_account.sh run/nodes/node30303`

* Store created account hash and paste into `node303.sh`. Add `0x` before account hash

## 3. Running nodes

* Start nodes

`./node303.sh`
`./node304.sh`

* Run mining on 304 node:
  You may set account to receive Eth with `miner.setEtherbase('0xACCOUNT_NUMBER_FROM_STEP_2')`, althouth it's not required

`miner.start(1)`

## Transfer eth between accounts

* Within geth console

`eth.sendTransaction({from:eth.coinbase, to: "0x3729277d8157a3acfbfbccb94f19873ec279c2d6", value: web3.toWei(1, "ether")})`