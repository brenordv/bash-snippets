#!/bin/bash
echo -e "\033[32m######################################################## \033[0m"
echo -e "\033[32mRedmine Install script for Docker. \033[0m"
echo -e "\033[32m \033[0m"
echo -e "\033[32mGood for testing, bad for production. This iscript uses \033[0m"
echo -e "\033[32monly test settings. \033[0m"
echo -e "\033[32m \033[0m"
echo -e "\033[32mhttp://raccoon.ninja \033[0m"
echo -e "\033[32m######################################################## \033[0m"
echo -e ""
echo -e "\033[32mUpdating apt-get... \033[0m"
#sudo apt-get --assume-yes update

echo -e "\033[32mInstalling Docker and Docker-Compose... \033[0m"
#sudo apt-get --assume-yes install docker.io docker-compose

echo -e "\033[32mGetting docker image for Redmine and applying it... \033[0m"
#sudo curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-redmine/master/docker-compose.yml > docker-compose.yml
#sudo docker-compose up -d

myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo -e ""
echo -e "\033[1mURL: \033[0m\033[32mhttp://$myip \033[0m"
echo -e "\033[1mDefault user: \033[0m\033[32muser \033[0m"
echo -e "\033[1mDefault password: \033[0m\033[32mbitnami1 \033[0m"
