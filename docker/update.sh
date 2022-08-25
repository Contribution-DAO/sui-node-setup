#!/bin/bash
echo -e "\033[0;33m"
echo "==========================================================================================================================="
echo " "
echo "  ██████╗ ██████╗ ███╗   ██╗████████╗██████╗ ██╗██████╗ ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗██████╗  █████╗  ██████╗ ";
echo " ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██║██╔══██╗██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗";
echo " ██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝██║██████╔╝██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║██║  ██║███████║██║   ██║";
echo " ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██║██╔══██╗██║   ██║   ██║   ██║██║   ██║██║╚██╗██║██║  ██║██╔══██║██║   ██║";
echo " ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║██║██████╔╝╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║╚██████╔╝";
echo "  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ";
                                                                                                                                                                                                 
echo -e "\033[0;33m"
echo "==========================================================================================================================="                                                                                    
sleep 1


echo -e "\e[1m\e[32mUpdating Sui fullnode... \e[0m" && sleep 1

cd $HOME/sui
sudo docker-compose down --volumes
rm genesis.blob
wget https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
wget https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml
wget https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
sudo cp fullnode-template.yaml fullnode.yaml
sudo sed -i 's/127.0.0.1/0.0.0.0/' fullnode.yaml
sudo sed -i 's/fullnode-template.yaml/fullnode.yaml/' docker-compose.yaml
docker rmi mysten/sui-node:stable
docker-compose up -d



echo "==========================================================================================================================="    



Container_ID=$(docker ps -q -f name=sui-fullnode-1)
result=$( docker inspect -f {{.State.Status}} $Container_ID)
if [ $result = "running" ]
then
echo -e "Your Sui node \e[32mUpdate and running normally\e[39m!"
else
echo -e "Your Sui node \e[31mUpdate failed\e[39m, Please Re-install."
fi
