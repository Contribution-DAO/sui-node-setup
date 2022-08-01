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

#Delete binary
sudo systemctl stop suid
sudo systemctl disable suid
sudo rm -rf ~/sui /var/sui/
sudo rm /etc/systemd/system/suid.service

sleep 1

#New install via docker.
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh < "/dev/null"

curl -SL https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chown $USER /var/run/docker.sock
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


cd $HOME
sudo mkdir -p sui
cd sui
wget https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml
sed -i 's/fullnode-template.yaml/fullnode.yaml/' docker-compose.yaml
wget https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
cp fullnode-template.yaml fullnode.yaml
sudo sed -i 's/127.0.0.1/0.0.0.0/' fullnode.yaml
wget https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
docker network create sui-network
docker-compose up -d
