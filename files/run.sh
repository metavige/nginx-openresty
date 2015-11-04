#!/bin/sh
#

ETCD="http://etcd:4001"
# Replace all confd templates and toml for spec. key
for f in $(ls -d /etc/confd/conf.d/*); do
  sed -i "s/HOSTNAME/${HOSTNAME}/g" $f
done
for f in $(ls -d /etc/confd/templates/*); do
  sed -i "s/HOSTNAME/${HOSTNAME}/g" $f
done

# Try to make initial configuration every 1 seconds until successful
until confd -onetime -backend="etcd" -node=$ETCD -log-level="error"; do
    # echo "[nginx] waiting for confd to create initial nginx configuration."
    sleep 1
done

# confd -interval=10 -backend="etcd" -node=$ETCD -log-level="error" &
# echo "[nginx] confd is now monitoring etcd for changes..."
#/etc/init.d/nginx start
#

touch /var/log/nginx/access.log && \
  tail -f /var/log/nginx/access.log &

# Run nginx
echo "[nginx] starting nginx service..."
nginx -c /etc/nginx/nginx.conf -g "daemon off;"

