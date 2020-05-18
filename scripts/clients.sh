#! /bin/bash

# Commands

# Let's create the OAuth 2.0 Client:

$ docker-compose -f hydra-dev.yml exec hydra \
    hydra clients create \
    --skip-tls-verify \
    --endpoint https://localhost:9001 \
    --id my-client \
    --secret secret \
    -g client_credentials

# Or using hydra binary if installed:
  hydra clients create --skip-tls-verify \
    --endpoint https://localhost:9001 \
    --id test3 \
    --secret some-secret \
    --grant-types authorization_code,refresh_token,client_credentials,implicit \
    --response-types token,code,id_token \
    --scope openid,offline,photos.read \
    --callbacks https://127.0.0.1:9010/callback

# List clients
hydra clients list --skip-tls-verify  --endpoint https://127.0.0.1:9001

# Simulate a client starting flow
hydra token user 
  --skip-tls-verify \
  --endpoint https://localhost:9000 \
  --port 9010 \
  --auth-url https://localhost:9000/oauth2/auth \
  --token-url https://localhost:9000/oauth2/token \
  --client-id test3 \
  --client-secret some-secret \
  --scope openid,offline,photos.read \
  --https

# To manually migrate DB:
hydra migrate sql --yes postgres://hydra:secret@localhost:5432/hydra?sslmode=disable


