# Sui Node Setup

### Sui Node Requirements
>:black_square_button: OS Ubuntu 18.04 or 20.04 <br>
>:black_square_button: 2 CPUs<br>
>:black_square_button: 8GB RAM<br>
>:black_square_button: 50GB Storage<br>
>:black_square_button: Port 9000, 9184<br>
>:black_square_button: Need Super user or root for run this script.<br>

## Official Site:
- Official web site : https://sui.io/
- Run a Sui Fullnode : https://github.com/MystenLabs/sui/blob/main/doc/src/build/fullnode.md
- Node health monitor : https://node.sui.zvalid.com/





# Set up Sui full node with auto script.
## Clone and Install Scripts

```
wget -q -O sui_setup.sh https://raw.githubusercontent.com/NunoyHaxxana/SUI/main/sui.sh && chmod +x sui_setup.sh && sudo /bin/bash sui_setup.sh
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


Send a request, the result should be something like this:
```json
{
  "title": "Sui JSON-RPC",
  "description": "Sui JSON-RPC API for interaction with the Sui network gateway.",
  "contact": {
    "name": "Mysten Labs",
    "url": "https://mystenlabs.com",
    "email": "build@mystenlabs.com"
  },
  "license": {
    "name": "Apache-2.0",
    "url": "https://raw.githubusercontent.com/MystenLabs/sui/main/LICENSE"
  },
  "version": "0.1.0"
}
```


## Register your node on discord
After fisnish install Sui node, You have register your node in the [Sui Discord](https://discord.gg/kqfQbYjUGq):
1) Go to Channel `#📋node-ip-application` 
2) Post your node ```http://<YOUR_NODE_IP>:9000/ ``` in Channel.
![image](https://user-images.githubusercontent.com/83507970/178087432-d8449b38-1f6a-4510-a31e-a85ea61b37e1.png)



## Monitor your node health status
1) Go to  https://node.sui.zvalid.com/
2) Insert your node ip

Send a request, the result should be something like this:
![image](https://user-images.githubusercontent.com/83507970/178087112-e547a097-83ca-4ea7-aa35-82567a944b86.png)


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
sudo rm -rf ~/sui /var/sui/
sudo rm /etc/systemd/system/suid.service
```
