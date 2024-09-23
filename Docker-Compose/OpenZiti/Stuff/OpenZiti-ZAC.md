#Update
sudo apt update
sudo apt upgrade -y

#Install Node.js & Angular
cd ~
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
npm install -g @angular/cli@16
    npm install -g npm@10.6.0
    --> npm Update

#Install ZAC
git clone https://github.com/openziti/ziti-console.git "${ZITI_HOME}/ziti-console"
cd "${ZITI_HOME}/ziti-console"
npm install
    export NODE_OPTIONS="--max-old-space-size=4096"
    --> Fixed heap out of memory
ng build ziti-console-lib
ng build ziti-console-node

#SSL Zertifikate einbinden
ln -s "${ZITI_PKI}/${ZITI_CTRL_EDGE_NAME}-intermediate/certs/${ZITI_CTRL_EDGE_ADVERTISED_ADDRESS}-server.chain.pem" "${ZITI_HOME}/ziti-console/server.chain.pem"
ln -s "${ZITI_PKI}/${ZITI_CTRL_EDGE_NAME}-intermediate/keys/${ZITI_CTRL_EDGE_ADVERTISED_ADDRESS}-server.key" "${ZITI_HOME}/ziti-console/server.key"

#Start scrypt & Starten
source /dev/stdin <<< "$(wget -qO- https://get.openziti.io/ziti-cli-functions.sh)"
createZacSystemdFile
sudo cp "${ZITI_HOME}/ziti-console.service" /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now ziti-console

node "${ZITI_HOME}/ziti-console/server.js"
Initializing TLS

#Kontrolle
sudo systemctl status ziti-console --lines=0 --no-pager
sudo ss -lntp | grep node