#!/bin/bash

# This script generates a dynamic .env file for Docker Compose

CURRENT_DIR=$(pwd)
USERNAME=$(whoami)
USER_UID=$(id -u)
USER_GID=$(id -g)

cat <<EOF > .env
USERNAME=${USERNAME}
UID=${USER_UID}
GID=${USER_GID}
PWD=${CURRENT_DIR}
EOF

echo ".env file generated:"
cat .env
