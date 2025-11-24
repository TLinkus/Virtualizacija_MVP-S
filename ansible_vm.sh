#!/bin/bash

if ! command -v onevm; then

sudo apt install -y curl wget gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
wget -q -O- https://downloads.opennebula.io/repo/repo2.key | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/opennebula.gpg

echo "deb [signed-by=/etc/apt/keyrings/opennebula.gpg] \
https://downloads.opennebula.io/repo/6.10/Ubuntu/24.04 stable opennebula" | \
sudo tee /etc/apt/sources.list.d/opennebula.list

sudo apt-get update
sudo apt-get install -y opennebula-tools

else

ssh-add
CUSER=tili1267
CPASS=Ltu120320#
CENDPOINT=https://grid5.mif.vu.lt/cloud3/RPC2
template="ubuntu-24.04"
VMname="ansible_project"
CVMREZ=$(onetemplate instantiate $template --name $VMname --user $CUSER --password $CPASS  --endpoint $CENDPOINT)
CVMID=$(echo $CVMREZ |cut -d ' ' -f 3)
echo $CVMID

echo "Laukiama kol virtuali masina pasileis"
sleep 40

$(onevm show $CVMID  --user $CUSER --password $CPASS  --endpoint $CENDPOINT >$CVMID.txt)
CSSH_CON=$(cat $CVMID.txt | grep CONNECT\_INFO1| cut -d '=' -f 2 | tr -d '"'|sed 's/'$CUSER'/root/')
CSSH_PRIP=$(cat $CVMID.txt | grep PRIVATE\_IP| cut -d '=' -f 2 | tr -d '"')
echo "Connection string: $CSSH_CON"
echo "Local IP: $CSSH_PRIP"
fi
echo "ansible masina sukurta"
