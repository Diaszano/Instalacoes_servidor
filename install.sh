#!/bin/bash
# ---------------------------------------------------
clear
# ---------------------------------------------------
sudo apt-get update -y
sudo apt-get upgrade -y 
sudo apt-get dist-upgrade -y 
# ---------------------------------------------------
clear
# ---------------------------------------------------
# Webmin - https://www.webmin.com/
# ---------------------------------------------------
nome=webmin
pacote=$(dpkg --get-selections | grep "$nome" ) 
if [ -n "$pacote" ] ;
then echo
    echo "$nome ja esta instalado!"
    sleep 5
else echo
    echo "Instalando $nome"
    echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee -a /etc/apt/sources.list 
    echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib"  | sudo tee -a /etc/apt/sources.list
    wget -q http://www.webmin.com/jcameron-key.asc -O-  | sudo apt-key add -
    sudo apt-get update -y 
    sudo apt-get install webmin apt-transport-https -y 
    wget https://prdownloads.sourceforge.net/webadmin/webmin_1.900_all.deb -O webmin.deb -y 
    sudo dpkg -i webmin.deb -y 
    sudo apt-get install -f -y
    clear  
    echo "Instalacao do $nome concluida"
    sleep 5
fi
# ---------------------------------------------------
clear
# ---------------------------------------------------
# Docker - https://www.docker.com/
# ---------------------------------------------------
nome=docker
pacote=$(dpkg --get-selections | grep "$nome" ) 
if [ -n "$pacote" ] ;
then echo
    echo "$nome ja esta instalado!"
    sleep 5
else echo
    echo "Instalando $nome"
    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt update -y
    apt-cache policy docker-ce -y
    sudo apt install docker-ce -y
    sudo usermod -aG docker ${USER}
    sudo - ${USER}
    sudo usermod -aG docker username
    echo "Instalacao do $nome concluida"
    sleep 5
    clear
    echo "Instalando Portainer"
    sudo docker volume create portainer_data
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:2.9.3
    echo "Instalacao do Portainer concluida"
    echo "https://localhost:9443"
    sleep 10
fi
# ---------------------------------------------------
clear
# ---------------------------------------------------
# Rclone - https://rclone.org/
# ---------------------------------------------------
nome=rclone
pacote=$(dpkg --get-selections | grep "$nome" ) 
if [ -n "$pacote" ] ;
then echo
    echo "$nome ja esta instalado!"
    sleep 5
else echo
    echo "Instalando $nome"
    curl https://rclone.org/install.sh | sudo bash
    echo "Instalacao do $nome concluida"
    sleep 5
fi
# ---------------------------------------------------
clear
# ---------------------------------------------------
sudo apt autoremove -y
# ---------------------------------------------------
clear
# ---------------------------------------------------
exit