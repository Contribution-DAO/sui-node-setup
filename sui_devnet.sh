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
git checkout -B devnet --track upstream/devnet

cargo build -p sui-node -p sui --release
mv ~/sui/target/release/sui-node /usr/local/bin/
mv ~/sui/target/release/sui /usr/local/bin/





echo -e "\e[1m\e[32m3. Update Configs \e[0m" && sleep 1
mkdir -p $HOME/.sui/
cd $HOME/.sui/
wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
wget -O fullnode.yaml https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
sed -i 's/127.0.0.1/0.0.0.0/'  $HOME/.sui/fullnode.yaml
sed -i "s|db-path:.*|db-path: $HOME/.sui/db|g" $HOME/.sui/fullnode.yaml
sed -i "s|genesis-file-location:.*|genesis-file-location: $HOME/.sui/genesis.blob|g" $HOME/.sui/fullnode.yaml





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
