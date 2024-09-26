#!/bin/bash

# Datos JSON que quieres enviar
data='{"vltSerialBoard": "'$SERIAL_NUMBER'"}'

# Realiza una solicitud POST a una API con datos en el cuerpo y guarda la respuesta en una variable
response=$(curl -s -X POST "https://4wmo907g8g.execute-api.us-east-1.amazonaws.com/default/vltTokenService" \
    -H "x-api-key: SJEIrlPFYs228YNrTbmNe4ocVWEKkvQB13k1Dlvd" \
    -H "Content-Type: application/json" \
    -d "$data")

vltName=$(echo "$response" | sed -n 's/.*"vltName": *"\([^"]*\)".*/\1/p')
vltCode=$(echo "$response" | sed -n 's/.*"vltCode": *"\([^"]*\)".*/\1/p')
storeid=$(echo "$response" | sed -n 's/.*"storeId": *"\([^"]*\)".*/\1/p')
latitude=$(echo "$response" | sed -n 's/.*"latitude": *"\([^"]*\)".*/\1/p')
longitude=$(echo "$response" | sed -n 's/.*"longitude": *"\([^"]*\)".*/\1/p')
opco=$(echo "$response" | sed -n 's/.*"opco": *"\([^"]*\)".*/\1/p')
cloudflaredtoken=$(echo "$response" | sed -n 's/.*"cloudflaredToken": *"\([^"]*\)".*/\1/p')
cloudflaredtunnelid=$(echo "$response" | sed -n 's/.*"cloudflaredTunnelId": *"\([^"]*\)".*/\1/p')