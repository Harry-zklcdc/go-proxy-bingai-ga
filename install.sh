#!/bin/bash

if [ "$TYPE" == "HIPER" ]; then
  wget -q https://gitcode.net/to/hiper/-/raw/master/linux-amd64/hiper -O /usr/local/bin/hiper
  chmod +x /usr/local/bin/hiper
  hiper -service install -config $HIPER_AUTH_TOKEN
  hiper -service start
  echo Setting Up Hiper
elif [ "$TYPE" == "NGROK" ]; then
  wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
  tar -xzf ngrok-v3-stable-linux-amd64.tgz
  ./ngrok config add-authtoken $NGROK_AUTH_TOKEN
  ./ngrok http 8080
  echo Setting Up Ngrok
elif [ "$TYPE" == "FRP" ]; then
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