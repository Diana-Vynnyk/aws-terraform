#!/bin/bash
yum -y update
yum -y install httpd

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="green">
<h2><font color="gold">Build with Terraform <font color="red"> v0.12</font></h2><br><p>
<font color="green">Created: ec2 instance and dynamic aws security group Server PrivateIP: <font color="aqua">$myip<br><br>

<font color="magenta">
<b>Version 2.0</b>
</body>
</html>
EOF


sudo service httpd start
chkconfig httpd on