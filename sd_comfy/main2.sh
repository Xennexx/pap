#!/bin/bash
set -e

current_dir=$(dirname "$(realpath "$0")")
cd $current_dir
source .env

# Set up a trap to call the error_exit function on ERR signal
trap 'error_exit "### ERROR ###"' ERR


if [[ -z "$INSTALL_ONLY" ]]; then
  echo "### Starting Stable Diffusion Comfy ###"
  log "Starting Stable Diffusion Comfy"
  cd "$REPO_DIR"
  PYTHONUNBUFFERED=1 service_loop "python main.py --dont-print-server --highvram --port 7100" > $LOG_DIR/sd_comfy_2.log 2>&1 &
  echo $! > /tmp/sd_comfy.pid
fi



if env | grep -q "PAPERSPACE"; then
  echo "Link: https://$PAPERSPACE_FQDN/com2/"
fi


echo "### Done ###"