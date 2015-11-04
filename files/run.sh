#!/bin/sh
#

tail -f /var/log/nginx/access.log &

# Run nginx
echo "[nginx] starting nginx service..."
nginx -c /etc/nginx/nginx.conf -g "daemon off;"

