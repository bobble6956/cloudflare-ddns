# cloudflare-ddns
Cloudflare Dynamic DNS update

## Introduction
A script for dynamically updating a CloudFlare DNS record.

## Dependencies
### 1. You'll need a JSON processor:
[https://stedolan.github.io/jq/](https://stedolan.github.io/jq/)

### 2. Allow outgoing to:
- [Cloudflare API](https://api.cloudflare.com)
- [ifconfig.io](http://ifconfig.io)

### 3. Having following resources:
- Cloudflare account
- Cloudflare API key
- An A record belong to 1 zone managed by Cloudflare

## Usage
To use this script, create a copy of the [cloudflare_ddns.sh.template](cloudflare_ddns.sh.template) file (and remove .template from the filename). 

Update below variable:
- domain='your_domain'
- zone='your_second&TLD_domain'
- email='your_email_address'
- api_key='your_api_key'

To do a one-off update of your DNS record, simply run this script from your terminal. The script will determine your public IP address and automatically update the CloudFlare DNS record along with it.

Because dynamic IPs can change regularly, it's recommended that you run this utility periodically in the background to keep the CloudFlare record up-to-date.

Just add a line to your crontab and let cron run it for you at a regular interval.

#### Example cron: every 15 minutes, check the current public IP, and update the A record on CloudFlare.
*/15 * * * * /path/to/code/cloudflare_ddns.sh >> /var/log/cloudflare_ddns.log 2>&1
