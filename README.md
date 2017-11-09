# Запуск Eth сети

* Создаем ноды
`./init_node.sh run/nodes/node30303`
`./init_node.sh run/nodes/node30303`

* Создаем учетную запись в 303 ноде. В качетсве пароля пишем sol1234
`./create_account.sh run/nodes/node30303`
Сохраняем номер аккаунта и подставляем его в файл `node303.sh`. Перед номером счета добавляем `0x`

* Запускаем BootNode:
`./bootnode.sh`
* Копируем адрес начинающийся с `enode://` и вставляем в файл `base_node.sh`. Вместо `[..]` пишем `127.0.0.1`

* Запускаем ноды:
./node303.sh
./node304.sh

* На 304 ноде запускаем майнинг:
`miner.setEtherbase('0xFFFF')`, где FFFF - номер аккаунта из 2 шага
`miner.start(1)`

* Перевод со счета на счет:
`eth.sendTransaction({from:eth.coinbase, to: "0x3729277d8157a3acfbfbccb94f19873ec279c2d6", value: web3.toWei(1, "ether")})`

