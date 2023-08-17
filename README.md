# 使用 Github Action 部署 go-proxy-bingai

## 使用方法

待补充~

## 机密环境变量

```bash
TYPE # 内网穿透飞方式 可选值 (不包含引号) 'NPS'、'NGROK'、'FRP'

# NPS
NPS_AUTH_TOKEN # NPS 验证令牌
NPS_ADDRESS    # NPS 服务器地址, eg: 1.2.3.4:34567
NPS_TYPE       # NPS 连接类型, 可选值 (不包含引号) 'tcp'、'kcp'

# NGROK
NGROK_AUTH_TOKEN # NGROK 验证令牌

# FRP
# 待补充
```