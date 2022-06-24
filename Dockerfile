FROM alpine:latest

RUN apk --no-cache add \
  certbot \
  openssl \
  netcat-openbsd \
  python3 \
  py3-pip \
  && python3 -m pip install certbot-dns-ovh

RUN mkdir -p /etc/periodic/12h
COPY start.sh certbot-ovh.sh /usr/local/bin/
COPY certbot-ovh.ini.tmpl /etc/certbot-ovh.ini.tmpl
COPY periodic/12h/certbot /etc/periodic/12h

VOLUME [ "/etc/letsencrypt/" ]
ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "start.sh" ]
