#!/bin/bash
yum -y update
yum -y install httpd
echo "<h2>This is a small Web Server</h2><br>Build by Terraform using External Script!"  >  /var/www/html/index.html
echo "<br><font color="blue">Created: ec2 instance and aws security group" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on