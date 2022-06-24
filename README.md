# Certbot for OVH

Run it and never care about your certificates again.

To run it provide the following environment variables:

- `CERTBOT_OVH_LE_EMAIL`: Your email address
- `CERTBOT_OVH_AGREE_TOS`: You need to agree to the terms of service, "yes" values: `1`, `y`, `t`
- `CERTBOT_OVH_DOMAINS`: Comma separated list of domain names for the certificate, example: `yourdomain.tld,*.yourdomain.tld`

Additionally the OVH API secrets must be configured. To do
so mount a file `/etc/certbot-ovh.ini` into the docker container.
See [certbot-ovh.ini.tmpl](certbot-ovh.ini.tmpl) for example contents.

## Example

A simple example can be found at [example](example/).

## SOURCE

[gitea.redxef.at/redxef/certbot-ovh](https://gitea.redxef.at/redxef/certbot-ovh)
