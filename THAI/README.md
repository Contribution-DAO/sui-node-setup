# คู่มือติดตั้ง SUI Full Node แบบ Brinary

### สเปคเครื่องที่ทาง SUI กำหนดมา
>:black_square_button: OS Ubuntu 20.04 ++<br>
>:black_square_button: 10 CPUs<br>
>:black_square_button: 32GB RAM<br>
>:black_square_button: 1T Storage<br>
>:black_square_button: Port 9000, 9184<br>
>:black_square_button: ควรใช้ user root ในการติดตั้ง .<br>








# สคริปต์ติดตั้ง SUI Full Node .

## ก่อนทำการติดตั้ง หรือ ทำการ update ให้ทำการ เปลี่ยน user เป็น root ก่อนทุกครั้ง 

```
sudo su
```

## เลือกรูปแบบโหนดที่ต้องการจะติดตั้ง ตอนนี้มีมั้ง Testnet และ Devnet แต่แนะนำให้ใช้ Testnet

### TESTNET

```
wget -q -O sui_testnet.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_testnet.sh && chmod +x sui_testnet.sh && sudo /bin/bash sui_testnet.sh
```



### DEVNET

```
wget -q -O sui_devnet.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_devnet.sh && chmod +x sui_devnet.sh && sudo /bin/bash sui_devnet.sh
```

## ตรวจสอบว่าโปรเซสของโหนดทำงานหรือไม่
```
service suid status
```
หากโหนดเราทำงานปกติจะได้ค่าตามรูปด้านล่าง:
![image](https://user-images.githubusercontent.com/83507970/178087315-579d82a4-1c19-4d1a-8b7a-7b74823dc917.png)


## ตรวจสอบการทำงานของโหนด
```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json' -d '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' | jq .result.info
```

## ตรวจสอบการ sync ของโหนดเรา ว่า sync ได้กี่ tx แล้ว
```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json'   --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```

## ตรวจสอบว่าตอนนี้ lasted tx บน sui network testnet อยู่ที่ tx เท่าใด
```
curl -s -X POST https://fullnode.testnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```

## ตรวจสอบว่าตอนนี้ lasted tx บน sui network devnet อยู่ที่ tx เท่าใด
```
curl -s -X POST https://fullnode.devnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```





## ตรวจสอบ node sync 
1) Go to  [https://node.sui.zvalid.com/](https://www.scale3labs.com/check/sui)
2) Insert your node ip

ถ้า node ของเรา sync ได้ปกติจะได้ประมาณรูปด้านล่าง:
![image](https://user-images.githubusercontent.com/83507970/214762796-528f77c1-1448-43a8-8169-c37b9dd3be8f.png)


## คำสั่งพื้นฐานต่าง ๆ
ตรวจสอบ status
```
service suid status
```

ตรวจสอบ logs
```
journalctl -u suid -f -o cat
```

Stop sui node 
```
sudo systemctl stop suid
```

Start sui node 
```
sudo systemctl start suid
```


Retart sui node 
```
sudo systemctl restart suid
```

หากต้องการลบ sui node ทิ้ง
```
sudo systemctl stop suid
sudo systemctl disable suid
sudo rm -rf $HOME/sui_node
sudo rm /etc/systemd/system/suid.service
```

# สคริปต์สำหรับใช้ upgade version.
## คัดลอก script ตาม network ที่เราติดตั้งอยู่ก่อนหน้า

### TESTNET

```
wget -q -O sui_testnet_update.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_testnet_update.sh && chmod +x sui_testnet_update.sh && sudo /bin/bash sui_testnet_update.sh
```



### DEVNET

```
wget -q -O sui_devnet_update.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_devnet_update.sh && chmod +x sui_devnet_update.sh && sudo /bin/bash sui_devnet_update.sh
```

