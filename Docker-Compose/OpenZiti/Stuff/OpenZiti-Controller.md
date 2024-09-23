#Update
sudo apt update
sudo apt upgrade -y
sudo apt install tar hostname jq curl

#Variablen befuellen
export EXTERNAL_DNS="$OPENZITI_URL"

export EXTERNAL_IP="$(curl -s eth0.me)"       
export ZITI_CTRL_EDGE_IP_OVERRIDE="${EXTERNAL_IP}"
export ZITI_ROUTER_IP_OVERRIDE="${EXTERNAL_IP}"
export ZITI_CTRL_EDGE_ADVERTISED_ADDRESS="${EXTERNAL_DNS:-${EXTERNAL_IP}}"
export ZITI_ROUTER_ADVERTISED_ADDRESS="${EXTERNAL_DNS:-${EXTERNAL_IP}}"
export ZITI_CTRL_ADVERTISED_PORT=8440
export ZITI_CTRL_EDGE_ADVERTISED_PORT=8441
export ZITI_ROUTER_PORT=8442

#Installation ausfuehren
source /dev/stdin <<< "$(wget -qO- https://get.openziti.io/ziti-cli-functions.sh)"; expressInstall
createControllerSystemdFile
createRouterSystemdFile "${ZITI_ROUTER_NAME}"

stopRouter 
stopController 

sudo cp "${ZITI_HOME}/${ZITI_CTRL_NAME}.service" /etc/systemd/system/ziti-controller.service
sudo cp "${ZITI_HOME}/${ZITI_ROUTER_NAME}.service" /etc/systemd/system/ziti-router.service
sudo systemctl daemon-reload
sudo systemctl enable --now ziti-controller
sudo systemctl enable --now ziti-router

sudo systemctl -q status ziti-controller --lines=0 --no-pager
sudo systemctl -q status ziti-router --lines=0 --no-pager

#Environment Variables Back to the Shell
source ~/.ziti/quickstart/$(hostname -s)/$(hostname -s).env
echo $ZITI_HOME