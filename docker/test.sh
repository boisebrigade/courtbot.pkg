#!/usr/bin/env bash

curl -X POST http://0.0.0.0:4001/sms/en -d "{\"Body\":\"BEEPBOOP\", \"From\":\"12084470077\"}" -H "Content-Type: application/json"
