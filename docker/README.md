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
## 1. Switch to root user

```
sudo su
```

## 2. Clone and Install Scripts

```
wget -q -O sui_setup.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/docker/sui_docker.sh && chmod +x sui_setup.sh && sudo /bin/bash sui_setup.sh
```




## 3. Check Node Status 
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


## 4. Monitor your node health status
1) Go to  https://node.sui.zvalid.com/
2) Insert your node ip

Click connect, the result should be something like this:
![image](https://user-images.githubusercontent.com/83507970/178087112-e547a097-83ca-4ea7-aa35-82567a944b86.png)



## 5. Register your node on discord
After fisnish install Sui node, You have register your node in the [Sui Discord](https://discord.gg/kqfQbYjUGq):
1) Go to Channel `#📋node-ip-application` 
2) Post your node ```http://<YOUR_NODE_IP>:9000/ ``` in Channel.
![image](https://user-images.githubusercontent.com/83507970/178087432-d8449b38-1f6a-4510-a31e-a85ea61b37e1.png)


## 6. Update sui node.

```
wget -q -O sui_update.sh https://raw.githubusercontent.com/Contribution-DAO/sui-node-setup/main/docker/update.sh && chmod +x sui_update.sh && sudo /bin/bash sui_update.sh
```



## Optional Command
Check sui node log

```docker logs -f sui-fullnode-1 --tail 50 ```

Restart sui node 

```docker-compose restart``` 

Stop sui node 

```docker-compose stop```

Start sui node 

```docker-compose start```

Check sui node process

```docker ps -a```

