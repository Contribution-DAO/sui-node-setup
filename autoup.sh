


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




echo -e "\e[1m\e[32m Update Sui fullnode \e[0m" && sleep 1
cd $HOME/sui_node
sudo systemctl stop suid
cd $HOME/sui_node
sudo rm -rf $HOME/sui_node/db
wget -O genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
wget -O fullnode.yaml https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
sed -i 's/127.0.0.1/0.0.0.0/'  $HOME/sui_node/fullnode.yaml
sed -i "s|db-path:.*|db-path: $HOME/sui_node/db|g" $HOME/sui_node/fullnode.yaml
sed -i "s|genesis-file-location:.*|genesis-file-location: $HOME/sui_node/genesis.blob|g" $HOME/sui_node/fullnode.yaml
version=$(wget -qO- https://api.github.com/repos/SecorD0/Sui/releases/latest | jq -r ".tag_name")
wget -qO- "https://github.com/SecorD0/Sui/releases/download/${version}/sui-linux-amd64-${version}.tar.gz" | sudo tar -C /usr/local/bin/ -xzf -
sudo systemctl start suid







echo "==========================================================================================================================="    

echo -e '\e[32mCheck your sui status\e[39m' && sleep 1
if [[ `service suid status | grep active` =~ "running" ]]; then
  echo -e "Your Sui node \e[32minstalled and running normally\e[39m!"
else
  echo -e "Your Sui node \e[31mwas failed installed\e[39m, Please Re-install."
fi

echo -e "\e[1m\e[32m6. Usefull commands \e[0m" && sleep 1
echo -e "Check your node logs: \e[1m\e[32m journalctl -fu suid -o cat \e[0m"
echo -e "Check your node status: \e[1m\e[32m sudo service suid status \e[0m"
echo -e "Restart your node: \e[1m\e[32m sudo systemctl restart suid \e[0m"
echo -e "Stop your node: \e[1m\e[32m sudo systemctl stop suid \e[0m"
echo -e "Start your node: \e[1m\e[32m sudo systemctl start suid \e[0m"



