 #!/usr/bin/env bash
echo "Hello from frontend!"
sudo yum install epel-release
sudo yum install nginx -y
cd ../../etc/
sudo chmod 777 nginx
cd nginx
sudo rm nginx.conf
cat > nginx.conf <<- "EOF"
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
  worker_connections  1024;
}
http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
  access_log  /var/log/nginx/access.log  main;
  sendfile        on;
  keepalive_timeout  65;
  server {
    listen       80;
    server_name  localhost;
    location / {
      root   /home/vagrant/dist;
      index  index.html;
      try_files $uri $uri/ /index.html;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
      root   /usr/share/nginx/html;
    }
  }
}
EOF
sudo systemctl start nginx
sudo systemctl enable nginx
cd ../../shared
tar -xvf dist.tar.gz -C /home/vagrant/
sudo systemctl reload nginx
sudo chmod +x /home/
sudo chmod +x /home/vagrant
sudo chmod +x /home/vagrant/dist	
