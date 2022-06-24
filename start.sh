#!/usr/bin/env sh

pids=""

run_prog() {
    "$@" &
    pids="$! $pids"
}

trap_sig() {
    printf '%s' "$pids" | while IFS= read -r pid; do
        echo "pid=$pid"
        # shellcheck disable=2086
        kill -s $1 $pid
    done
}

trap 'trap_sig TERM' TERM

if [ ! -f "/etc/certbot-ovh.ini" ]; then
    echo "No certbot ovh configuration file found" >&2
    echo "Please mount it at /etc/certbot-ovh.ini" >&2
    echo "Example config at /etc/certbot-ovh.ini.tmpl" >&2
    exit 1
fi

if [ -z "$CERTBOT_OVH_LE_EMAIL" ]; then
    echo "Please provide the lets encrypt email address" >&2
    echo "Specify CERTBOT_OVH_LE_EMAIL=<your_email>" >&2
    exit 2
fi

if [ -z "$CERTBOT_OVH_DOMAINS" ]; then
    echo "Please provide the domains for this certificate" >&2
    echo "Example: CERTBOT_OVH_DOMAINS=domain1.tld,*.domain1.tld"
    exit 3
fi

echo "Writing crond config" >&2
printf '*\t*/12\t*\t*\t*\trun-parts /etc/periodic/12h\n' >> /etc/crontabs/root
crontab -l

run_prog crond -l 0 -fc /etc/crontabs/

echo "Starting certbot" >&2
run_prog certbot-ovh.sh
# shellcheck disable=2086
wait $pids
