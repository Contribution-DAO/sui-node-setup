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

echo -e "\e[1m\e[32m1. Updating packages \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y


echo -e "\e[1m\e[32m2. Install dependencies \e[0m" && sleep 1
sudo apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends tzdata git ca-certificates curl build-essential libssl-dev pkg-config libclang-dev cmake jq
sudo apt install libprotobuf-dev protobuf-compiler
wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb


echo -e "\e[1m\e[32m3. Install Rust \e[0m" && sleep 1
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env


echo -e "\e[1m\e[32m4. Download Sui Binaries \e[0m" && sleep 1
cd $HOME
rm -rf sui
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout -B testnet --track upstream/testnet

cargo build -p sui-node -p sui --release
mv ~/sui/target/release/sui-node /usr/local/bin/
mv ~/sui/target/release/sui /usr/local/bin/





echo -e "\e[1m\e[32m3. Update Configs \e[0m" && sleep 1
mkdir -p $HOME/.sui/
cd $HOME/.sui/
wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
wget -O fullnode.yaml https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
sed -i 's/127.0.0.1/0.0.0.0/'  $HOME/.sui/fullnode.yaml
sed -i "s|db-path:.*|db-path: $HOME/.sui/db|g" $HOME/.sui/fullnode.yaml
sed -i "s|genesis-file-location:.*|genesis-file-location: $HOME/.sui/genesis.blob|g" $HOME/.sui/fullnode.yaml

sudo tee -a $HOME/.sui/fullnode.yaml  >/dev/null <<EOF

p2p-config:
  seed-peers:
   - address: "/dns/seoul-1.sui.nodiums.com/udp/9999"
   - address: "/dns/seoul-2.sui.nodiums.com/udp/9999"
   - address: "/dns/singapore-1.sui.nodiums.com/udp/9999"
   - address: "/dns/singapore-2.sui.nodiums.com/udp/9999"
   - address: "/dns/singapore-3.sui.nodiums.com/udp/9999"
   - address: "/dns/singapore-4.sui.nodiums.com/udp/9999"
   - address: "/dns/toronto-1.sui.nodiums.com/udp/9999"
   - address: "/dns/mumbai-1.sui.nodiums.com/udp/9999"
   - address: "/dns/los-angeles-1.sui.nodiums.com/udp/9999"
   - address: "/dns/dallas-1.sui.nodiums.com/udp/9999"
   - address: "/ip4/65.109.32.171/udp/8084"
   - address: "/ip4/65.108.44.149/udp/8084"
   - address: "/ip4/95.214.54.28/udp/8080"
   - address: "/ip4/136.243.40.38/udp/8080"
   - address: "/ip4/84.46.255.11/udp/8084"
   - address: "/ip4/135.181.6.243/udp/8088"
   - address: "/ip4/89.163.132.44/udp/8080"
   - address: "/ip4/95.217.57.232/udp/8080"
   - address: "/ip4/15.204.163.225/udp/8080"
   - address: "/ip4/65.108.68.119/udp/8080"
   - address: "/ip4/155.133.22.151/udp/8080"
   - address: "/ip4/45.14.194.21/udp/8080"
   - address: "/ip4/159.69.58.44/udp/8080"
   - address: "/ip4/139.180.130.95/udp/8084"
   - address: "/ip4/51.178.73.193/udp/8084"
   - address: "/ip4/162.19.84.43/udp/8084"
   - address: "/ip4/146.59.68.207/udp/8080"
   - address: "/ip4/89.58.5.19/udp/8084"
   - address: "/ip4/38.242.227.80/udp/8080"
   - address: "/ip4/144.217.10.44/udp/8080"
   - address: "/ip4/178.18.250.62/udp/8080"
   - address: "/ip4/213.239.215.119/udp/8084"
   - address: "/ip4/65.109.32.171/udp/8084"
   - address: "/ip4/65.108.44.149/udp/8084"
   - address: "/ip4/95.214.54.28/udp/8080"
   - address: "/ip4/136.243.40.38/udp/8080"
   - address: "/ip4/84.46.255.11/udp/8084"
   - address: "/ip4/135.181.6.243/udp/8088"
EOF




echo -e "\e[1m\e[32m5. Make Sui Service \e[0m" && sleep 1
sudo tee /etc/systemd/system/suid.service > /dev/null <<EOF
[Unit]
Description=Sui node
After=network-online.target

[Service]
User=$USER
ExecStart=/usr/local/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF


sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF




sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid



echo "==========================================================================================================================="    

echo -e '\e[32mCheck your sui status\e[39m' && sleep 1
if [[ `service suid status | grep active` =~ "running" ]]; then
  echo -e "Your Sui node \e[32minstalled and running normally\e[39m!"
else
  echo -e "Your Sui node \e[31mwas failed installed\e[39m, Please Re-install."
fi

echo " "
echo -e "\e[1m\e[34mYour Sui Version : $(sui -V)\e[0m" && sleep 1
echo " "
echo " "
echo " "
echo -e "\e[1m\e[32m6. Usefull commands \e[0m" && sleep 1
echo -e "Check your node logs: \e[1m\e[32m journalctl -fu suid -o cat \e[0m"
echo -e "Check your node status: \e[1m\e[32m sudo service suid status \e[0m"
echo -e "Restart your node: \e[1m\e[32m sudo systemctl restart suid \e[0m"
echo -e "Stop your node: \e[1m\e[32m sudo systemctl stop suid \e[0m"
echo -e "Start your node: \e[1m\e[32m sudo systemctl start suid \e[0m"
