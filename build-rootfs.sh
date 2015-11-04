#!/bin/bash

# echo "==> add http/2 patch..."
# wget http://nginx.org/patches/http2/patch.http2.txt
# patch -p1 < patch.http2.txt

echo "build nginx with lua ..... "
cd /ngx_openresty
./configure \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--error-log-path=/var/log/nginx/error.log \
	--http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
	--lock-path=/var/lock/nginx.lock \
	--pid-path=/var/run/nginx.pid \
	--with-luajit \
	--without-http_scgi_module \
	--without-http_uwsgi_module \
	--without-http_fastcgi_module \
	--without-http_autoindex_module \
	--with-http_gzip_static_module \
	--with-http_realip_module \
	--with-http_stub_status_module \
	# --with-http_v2_module \
	--with-pcre \
	--with-sha1=/usr/include/openssl \
	--with-md5=/usr/include/openssl \
	--with-http_stub_status_module

make
make install

echo "==> Clear screen..."
cd ..
clear

echo "==> Investigate required .so files..."
ldd /usr/sbin/nginx

echo "==> Extract .so files and pack them into rootfs.tar.gz..."
#curl -sSL http://bit.ly/install-extract-elf-so | bash
cd /tmp
extract-elf-so  \
  /usr/sbin/nginx

tar -uvf rootfs.tar /etc/nginx

gzip -f rootfs.tar

cp rootfs.tar.gz /data/
cp /usr/sbin/nginx /data/files/usr/sbin/
