# 使用 Github Action 部署 go-proxy-bingai

## 使用方法

待补充~

## 机密环境变量

```bash
TYPE # 内网穿透方式 可选值 (不包含引号) 'HIPER'、'NPS'、'NGROK'、'FRP'

# HIPER
HIPER_AUTH_TOKEN # Hiper 凭证兑换码

# NPS
NPS_AUTH_TOKEN # NPS 验证令牌
NPS_ADDRESS    # NPS 服务器地址, eg: 1.2.3.4:34567
NPS_TYPE       # NPS 连接类型, 可选值 (不包含引号) 'tcp'、'kcp'

# NGROK
NGROK_AUTH_TOKEN # NGROK 验证令牌

# FRP
FRP_TYPE          # Frp 的类型, 可选值 (不包含引号) 'SAKURA' 或 为空
FRP_AUTH_TOKEN    # Frp 的验证令牌, `FRP_TYPE` 值为空时, eg: gobingaifrp; `FRP_TYPE` 值为 'SAKURA' 时, eg: gobingaifrp:114514
FRP_ADDRESS       # Frp 服务器地址, `FRP_TYPE` 值为空时必填 eg: 1.2.3.4
FRP_PORT          # Frp 服务器端口, `FRP_TYPE` 值为空时必填 eg: 11451
FRP_USER          # Frp 服务的用户名, `FRP_TYPE` 值为空时必填 eg: gobingai
FRP_DOMAIN        # Frp 服务绑定的域名, `FRP_TYPE` 值为空时必填 eg: gobingai.com
```