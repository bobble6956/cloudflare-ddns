#/bin/sh
set -e

api_url='https://api.cloudflare.com/client/v4/'

#your desired ddns domain "ddns.example.com"
domain='your_domain'

#your second and TLD domain "example.com"
zone='your_second&TLD_domain'

#your login email address
email='your_email_address'

#you can find your api key here: https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-Cloudflare-API-key-
api_key='your_api_key'

zone_id="$(curl -sX GET "$api_url/zones" \
                -H "X-Auth-Email: $email" \
                -H "X-Auth-Key: $api_key" \
                -H "Content-Type: application/json" \
                | jq -r '.result[] | select (.name | contains("'$zone'"))' | jq -r .id)"

account_id="$(curl -sX GET "$api_url/zones" \
                   -H "X-Auth-Email: $email" \
                   -H "X-Auth-Key: $api_key" \
                   -H "Content-Type: application/json" \
                   | jq -r '.result[] | select (.name | contains("'$zone'"))' | jq -r .account.id)"

record_id="$(curl -sX GET "$api_url/zones/$zone_id/dns_records?type=A&name=$domain&direction=desc&match=all" \
                  -H "X-Auth-Email: $email" \
                  -H "X-Auth-Key: $api_key" \
                  -H "Content-Type: application/json" \
                  | jq -r '.result[] | select (.name | contains("'$domain'"))' | jq -r .id)"

public_ip=$(curl -s ifconfig.io)
current_ip=$(dig +short $domain)

if [ "$public_ip" == "$current_ip" ]; then
    echo $(date)
    echo "DON'T need to update"
else
    echo $(date)
    echo "Updated IP is"
    curl -sX PUT "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id" \
         -H "X-Auth-Email: $email" \
         -H "X-Auth-Key: $api_key" \
         -H "Content-Type: application/json" \
         --data '{"type":"A","name":"'$domain'","content":"'$public_ip'","ttl":1,"proxied":false}' \
         | jq -r .result.content
fi