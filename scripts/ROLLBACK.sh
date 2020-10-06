#!/bin/bash
sleep 10
##Deploying application from Temp_Location based on the name
if [ -f "/opt/wildfly/standalone/deployments/clmaster.war" ];
then
mv  /opt/Temp_Location/clmaster.war /opt/wildfly/standalone/deployments/clmaster.war
else
echo ""
fi
if [ -f "/opt/wildfly/standalone/deployments/clmaster100.war" ];
then
mv  /opt/Temp_Location/clmaster.war /opt/wildfly/standalone/deployments/clmaster100.war
else
echo ""
fi
cd /opt
rm -rf Temp_Location ##removed temp location of deployment
sudo systemctl start wildfly
sleep 50
if [ -f "/opt/wildfly/standalone/deployments/clmaster.war.failed" ];
then
tar -xvf /backup/clmaster.war.tar.gz_$(date +%d%b%Y) --directory /opt/wildfly/standalone/deployments/
sleep 15
cd /opt/wildfly/standalone/deployments/
mv clmaster.war.failed  clmaster.war.dodeploy
sleep 30
echo "Deployment of clmaster.war.tar.gz_$(date +%d%b%Y) is rollbacked ">>/backup/logs/Staus_Bakup.log
else
echo ""
fi

if [ -f "/opt/wildfly/standalone/deployments/clmaster100.war.failed" ];
then
tar -xvf /backup/clmaster100.war.tar.gz_$(date +%d%b%Y) --directory /opt/wildfly/standalone/deployments/
sleep 15
cd /opt/wildfly/standalone/deployments/
mv clmaster100.war.failed  clmaster100.war.dodeploy
sleep 30
echo "Deployment of clmaster100.war.tar.gz_$(date +%d%b%Y) is rollbacked ">>/backup/logs/Staus_Bakup.log
else
echo ""
fi
cd /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive/
rm -rf clmaster.war 

sleep 30

URL="$(wget -S --spider http://172.31.87.183:80/clmaster/ 2>&1 | awk '/^  /' | head -1)"

if [[ $URL = "  HTTP/1.1 200 OK" ]] ; then
        echo "Server is Up"
else
        echo "Server is Down"
fi
