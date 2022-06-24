#!/usr/bin/env sh

yes_options="
1
y
t
"

if [ -n "$CERTBOT_OVH_AGREE_TOS" ] && echo "$yes_options" | grep -wiq "$CERTBOT_OVH_AGREE_TOS"; then
    agree_tos=--agree-tos
else
    agree_tos=
fi 

# shellcheck disable=SC2086
certbot certonly --preferred-challenges dns-01 --keep \
  --email="$CERTBOT_OVH_LE_EMAIL" --domains="$CERTBOT_OVH_DOMAINS" \
  --no-eff-email --manual-public-ip-logging-ok \
  --dns-ovh --dns-ovh-credentials /etc/certbot-ovh.ini $agree_tos
