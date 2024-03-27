#!/bin/bash
# Generate self-signed certificates for GitLab

# must be run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi


GITLAB_DN="/C=CA/ST=QUEBEC/L=MONTREAL/O=EXAMPLE"
GITLAB_DATA_DIR=/var/lib/docker/volumes/gitlab-azure-oauth_gitlab-data/_data

mkdir -p "$GITLAB_DATA_DIR/certs"

cd "$GITLAB_DATA_DIR/certs"
openssl genrsa -out gitlab.key 2048
openssl req -new -key gitlab.key -out gitlab.csr
openssl x509 -req -days 3650 -in gitlab.csr -signkey gitlab.key -out gitlab.crt
openssl dhparam -out dhparam.pem 2048
