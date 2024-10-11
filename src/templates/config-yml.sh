TEMPLATE_CONFIG_YML="tunnel: $cloudflaredtunnelid
no-autoupgrade: true
ingress:
  - hostname: $vltName.ainigmaim.com
    service: http://localhost:9100
  - hostname: ssh-$vltName.ainigmaim.com
    service: ssh://localhost:22
  - service: http_status:404
"
