# Sui Node Setup

### Sui Node Requirements
>:black_square_button: OS Ubuntu 18.04 or 20.04 <br>
>:black_square_button: 10 CPUs<br>
>:black_square_button: 32GB RAM<br>
>:black_square_button: 1000GB Storage<br>
>:black_square_button: Port 9000, 9184<br>
>:black_square_button: Need Super user or root for run this script.<br>

## Official Site:
- Official web site : https://sui.io/
- Run a Sui Fullnode : https://github.com/MystenLabs/sui/blob/main/doc/src/build/fullnode.md
- Node health monitor : https://node.sui.zvalid.com/





# Set up Sui full node with auto script.
## Clone and Install Scripts

### TESTNET

```
wget -q -O sui_testnet.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_testnet.sh && chmod +x sui_testnet.sh && sudo /bin/bash sui_testnet.sh
```



### DEVNET

```
wget -q -O sui_devnet.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_devnet.sh && chmod +x sui_devnet.sh && sudo /bin/bash sui_devnet.sh
```

## Verify your node running
```
service suid status
```
Send a request, the result should be something like this:
![image](https://user-images.githubusercontent.com/83507970/178087315-579d82a4-1c19-4d1a-8b7a-7b74823dc917.png)


## Check Node Status 
```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json' -d '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' | jq .result.info
```

## Check the latest TX on your node
```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json'   --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```

## Check the latest TX on testnet chain 
```
curl -s -X POST https://fullnode.testnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```

## Check the latest TX on devnet chain 
```
curl -s -X POST https://fullnode.devnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq 
```





## Monitor your node health status
1) Go to  [https://node.sui.zvalid.com/](https://www.scale3labs.com/check/sui)
2) Insert your node ip

Send a request, the result should be something like this:
![image](https://user-images.githubusercontent.com/83507970/214762796-528f77c1-1448-43a8-8169-c37b9dd3be8f.png)


## Optional Command
Check sui node status
```
service suid status
```

Check sui node logs
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

Delete sui node 
```
sudo systemctl stop suid
sudo systemctl disable suid
sudo rm -rf $HOME/sui_node
sudo rm /etc/systemd/system/suid.service
```

# Update Sui full node with auto script.
## Clone and Install Scripts

### TESTNET

```
wget -q -O sui_testnet_update.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_testnet_update.sh && chmod +x sui_testnet_update.sh && sudo /bin/bash sui_testnet_update.sh
```



### DEVNET

```
wget -q -O sui_devnet_update.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/sui_devnet_update.sh && chmod +x sui_devnet_update.sh && sudo /bin/bash sui_devnet_update.sh
```

