#!/bin/bash
if [ -d "/backup" ];
then
echo ""
else
mkdir /backup
fi


if [ -d "/backup/logs" ];
then
echo ""
else
cd  /backup
mkdir logs
fi


if [ -d "/opt/Temp_Location" ];
then
echo ""
else
mkdir /opt/Temp_Location
fi



if [ -f "/opt/wildfly/standalone/deployments/clmaster.war" ];
then
cd /opt/wildfly/standalone/deployments/
tar -cvf /backup/clmaster.war.tar.gz_$(date +%d%b%Y) clmaster.war ##Taking backup
if [ $? -eq 0 ]; then
    echo "Taken backup of clmaster.war.tar.gz_$(date +%d%b%Y) Successfully on $(date +%d%b%Y_%H:%M:%S) ">> /backup/logs/Staus_Bakup.log
cat /backup/logs/Staus_Bakup.log
else
    echo "No backup of clmaster.war.tar.gz_$(date +%d%b%Y)  taken on $(date +%d%b%Y_%H:%M:%S)">> /backup/logs/Staus_Bakup.log
    cat /backup/logs/Staus_Bakup.log
fi
else
echo ""
fi


if [ -f "/opt/wildfly/standalone/deployments/clmaster100.war" ];
then
cd /opt/wildfly/standalone/deployments/
tar -cvf /backup/clmaster100.war.tar.gz_$(date +%d%b%Y) clmaster100.war ##Taking backup
if [ $? -eq 0 ]; then
    echo "Taken backup of clmaster100.war.tar.gz_$(date +%d%b%Y) Successfully on $(date +%d%b%Y_%H:%M:%S) ">> /backup/logs/Staus_Bakup.log
cat /backup/logs/Staus_Bakup.log
else
    echo "No backup of clmaster100.war.tar.gz_$(date +%d%b%Y)  taken on $(date +%d%b%Y_%H:%M:%S)">> /backup/logs/Staus_Bakup.log
    cat /backup/logs/Staus_Bakup.log
fi
else
echo ""
fi


chmod -R 775 /backup
sudo systemctl stop wildfly ##stopping the server
sleep 40
