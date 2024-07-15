#!/bin/bash


sudo yum install nginx -y 

sudo systemctl start nginx
sudo systemctl enable nginx


cat <<EOF > /usr/share/nginx/html/index.html

<html>
<head>
<title> Terraform setup </head>
</title>
<body>
<center>
<h1> Welcome to terraform World</h1>
</body>
</html>

EOF