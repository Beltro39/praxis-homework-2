#!/usr/bin/env bash
echo "Hello world!"
sudo yum install git -y
wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
sha256sum go1.13.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
source ~/.bash_profile
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install nodejs -y
sudo npm install -g @vue/cli
git clone https://github.com/jdmendozaa/vuego-demoapp.git
sudo chmod 777 vuego-demoapp/server
cd vuego-demoapp/server
go build
sudo mv vuego-demoapp ../../../../shared/
cd ../
sudo chmod 777 spa 
cd spa
cat > .env <<- "EOF"
VUE_APP_API_ENDPOINT="http://10.0.0.8:4001/api"
EOF
sudo npm install
sudo npm install sass
sudo npm run build
tar -czvf dist.tar.gz dist
mv dist.tar.gz ../../../../shared/

