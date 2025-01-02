TEMPLATE_CONFIG_YML="tunnel: $cloudflaredtunnelid
no-autoupgrade: true
ingress:
  - hostname: $vltName.apuestasport.co
    service: http://localhost:9100
  - hostname: ssh-$vltName.apuestasport.co
    service: ssh://localhost:22
  - service: http_status:404
"
