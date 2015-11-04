FROM debian:jessie
MAINTAINER Ricky Chiang <metavige@gmail.com>

ADD rootfs.tar.gz /
ADD files /

RUN mkdir -p /var/lib/nginx/body && \
    mkdir -p /var/lib/nginx/proxy && \
    mkdir -p /var/log/nginx &&
    touch /var/log/nginx/access.log &&
    touch /var/log/nginx/error.log

EXPOSE 80

CMD ["/run.sh"]
