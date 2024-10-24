#!/usr/bin/bash

/usr/bin/sudo /usr/bin/yum check-update
/usr/bin/sudo /usr/bin/yum -y update
/usr/bin/sudo /usr/bin/yum -y install wget curl tar gettext iptables

PUBLIC_IP=$(/usr/bin/curl http://169.254.169.254/latest/meta-data/public-ipv4)
PRIVATE_IP=$(/usr/bin/curl http://169.254.169.254/latest/meta-data/local-ipv4)

cd /home/devops/latest
/usr/bin/sudo /usr/bin/sed -i "s/^DOMAINS=/DOMAINS=$PUBLIC_IP,$PRIVATE_IP/g" config-example.txt
/usr/bin/echo "n" | sudo ./jmsctl.sh install
sudo ./jmsctl.sh start
sleep 180