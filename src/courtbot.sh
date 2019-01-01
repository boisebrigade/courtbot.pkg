#!/usr/bin/bash
set -euo pipefail

COURTBOT_BINARY="/opt/app/bin/courtbot"
COURTBOT_PORT=${PORT:-4000}
COURTBOT_CONFIG=${CONFIG:-"/etc/courtbot/"}
COURTBOT_DATA=${DATA_DIR:-"/tmp"}

print_help() {
  cat << EOL
Usage: courtbot COMMAND

Commands:
  import    Import data into Courtbot
  notify    Send out pending notifications
  start     Start Courtbot
  stop      Stop Courtbot
  logs      View Courtbot logs
  help      Print usage
EOL
}


is_running?() {
  docker top courtbot &>/dev/null
}

stop_courtbot() {
  docker stop courtbot  &>/dev/null || true
  docker rm -f courtbot &>/dev/null || true
}

case $1 in
     "import")
          docker exec courtbot $COURTBOT_BINARY import
          ;;
     "notify")
          docker exec courtbot $COURTBOT_BINARY notify
          ;;
     "reset")
          read -p "Are you sure? This will delete all subscription and imported data" -n 1 -r
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]
          then
              docker exec courtbot $COURTBOT_BINARY reset
          fi
          ;;
     "start")
          stop_courtbot

          docker pull codeforboise/courtbot:latest
          docker run --log-driver=journald --restart=always --name courtbot -p $COURTBOT_PORT:4000 -v "$COURTBOT_CONFIG":/opt/app/etc/courtbot -v "$COURTBOT_DATA":/tmp codeforboise/courtbot:latest
          ;;
     "stop")
          stop_courtbot
          ;;

     "logs")
          journalctl CONTAINER_NAME=courtbot
          ;;

     "help")
          print_help
          ;;
     *)
          print_help
          ;;
esac
