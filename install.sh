#!/bin/bash

Install_Hiper(){
  wget -q https://gitcode.net/to/hiper/-/raw/master/linux-amd64/hiper -O /usr/local/bin/hiper
  chmod +x /usr/local/bin/hiper
  sudo hiper -service install -config $HIPER_AUTH_TOKEN
  sudo hiper -service start
  echo Setting Up Hiper
}

Install_CFT(){
  curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
  sudo dpkg -i cloudflared.deb && 
  sudo cloudflared service install $CFT_AUTH_TOKEN
}

Install_Ngrok(){
  wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
  tar -xzf ngrok-v3-stable-linux-amd64.tgz
  chmod +x ./ngrok
  ./ngrok config add-authtoken $NGROK_AUTH_TOKEN
  ./ngrok http 8080
  echo Setting Up Ngrok
}

Install_Frp_SAKURA(){
  wget -q https://nya.globalslb.net/natfrp/client/frpc/0.45.0-sakura-7/frpc_linux_amd64
  mv ./frpc_linux_amd64 ./frpc && chmod +x ./frpc
  sudo ./frpc -f $FRP_AUTH_TOKEN
  echo Setting Up Frp SAKURA
}

Install_Frp_OTHER(){
  FRP_FILE_URL=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep linux_amd64 | grep browser_download_url | cut -d '"' -f 4)
  wget -q ${FRP_FILE_URL} -O frp.tar.gz
  tar -xzf frp.tar.gz
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
  echo Setting Up Frp Other
}

Install_NPS(){
  wget -q https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_client.tar.gz
  tar -xzf linux_amd64_client.tar.gz
  chmod +x ./npc
  sudo ./npc install -server="$NPS_ADDRESS" -vkey="$NPS_AUTH_TOKEN" -type="$NPS_TYPE"
  sudo rm -rf linux_amd64_client.tar.gz conf
  sudo npc start
  echo Setting Up NPS
}

if [ "$TYPE" == "HIPER" ]; then
  Install_Hiper
elif [ "$TYPE" == "CFT" ]; then
  Install_CFT
elif [ "$TYPE" == "NGROK" ]; then
  Install_Ngrok
elif [ "$TYPE" == "NPS" ]; then
  Install_NPS
elif [ "$TYPE" == "FRP" ]; then
  if [ "$FRP_TYPE" == "SAKURA" ]; then
    Install_Frp_SAKURA
  else
    Install_Frp_OTHER
  fi
fi