#!/bin/bash

if [ "$TYPE" == "HIPER" ]; then
  wget -q https://gitcode.net/to/hiper/-/raw/master/linux-amd64/hiper -O /usr/local/bin/hiper
  chmod +x /usr/local/bin/hiper
  sudo hiper -service install -config $HIPER_AUTH_TOKEN
  sudo hiper -service start
  echo Setting Up Hiper
elif [ "$TYPE" == "NGROK" ]; then
  wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
  tar -xzf ngrok-v3-stable-linux-amd64.tgz
  chmod +x ./ngrok
  ./ngrok config add-authtoken $NGROK_AUTH_TOKEN
  ./ngrok http 8080
  echo Setting Up Ngrok
elif [ "$TYPE" == "FRP" ]; then
  if [ "$FRP_TYPE" == "SAKURA" ]; then
    wget -q https://nya.globalslb.net/natfrp/client/frpc/0.45.0-sakura-7/frpc_linux_amd64
    mv ./frpc_linux_amd64 ./frpc && chmod +x ./frpc
    sudo ./frpc -f $FRP_AUTH_TOKEN
  else
    wget -q https://github.com/fatedier/frp/releases/download/v0.51.3/frp_0.51.3_linux_amd64.tar.gz
    tar -xzf frp_0.51.3_linux_amd64.tar.gz
    mv ./frp_0.51.3_linux_amd64/frpc ./frpc && chmod +x ./frpc
    cat >./frpc.ini<<EOF
[common]
server_addr = $FRP_ADDRESS
server_port = $FRP_PORT
user = $FRP_USER
token = $FRP_AUTH_TOKEN
[test_htts2http]
type = https
custom_domains = $FRP_DOMAIN
plugin = https2http
plugin_local_addr = 127.0.0.1:8080
plugin_host_header_rewrite = 127.0.0.1
plugin_header_X-From-Where = frp
EOF
    sudo ./frpc -c ./frpc.ini
  fi
  echo Setting Up Frp
elif [ "$TYPE" == "NPS" ]; then
  wget -q https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_client.tar.gz
  tar -xzf linux_amd64_client.tar.gz
  chmod +x ./npc
  sudo ./npc install -server="$NPS_ADDRESS" -vkey="$NPS_AUTH_TOKEN" -type="$NPS_TYPE"
  sudo rm -rf linux_amd64_client.tar.gz conf
  sudo npc start
  echo Setting Up NPS
fi