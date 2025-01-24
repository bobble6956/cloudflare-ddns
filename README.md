# Cloudflare Dynamic DNS Updater

## Overview

A shell script for automatically updating Cloudflare DNS A records with your current public IP address, ideal for home servers or dynamic IP networks.

## Features

- Automatically detect public IP address
- Compare current DNS record with public IP
- Update Cloudflare DNS record if IP has changed
- Minimal logging for tracking updates
- Configurable via environment variables

## Prerequisites

### Dependencies

- `curl`: For making API calls and fetching public IP
- `jq`: JSON processor for parsing Cloudflare API responses

### Cloudflare Requirements

- Cloudflare account
- API key with DNS record modification permissions
- Managed DNS zone
- Existing A record to update

## Installation

1. Clone the repository:
   ```bash
   git clone https://your-repo-url/cloudflare-ddns.git
   cd cloudflare-ddns
   ```

2. Copy the template configuration:
   ```bash
   cp cloudflare_ddns.sh.template cloudflare_ddns.sh
   chmod +x cloudflare_ddns.sh
   ```

3. Configure environment variables:
   ```bash
   export CLOUDFLARE_DOMAIN=your_domain
   export CLOUDFLARE_ZONE=your_second_tld_domain
   export CLOUDFLARE_EMAIL=your_email_address
   export CLOUDFLARE_API_KEY=your_api_key
   ```

## Usage

### One-time Update

Run the script directly to perform a single DNS update:

```bash
./cloudflare_ddns.sh
```

### Periodic Updates with Cron

For continuous IP tracking, set up a cron job:

```bash
# Edit crontab
crontab -e

# Add this line to run every 15 minutes
*/15 * * * * /path/to/cloudflare_ddns.sh >> /var/log/cloudflare_ddns.log 2>&1
```

## Security Considerations

- Keep your API key confidential
- Use read-restricted log files
- Consider using more secure credential management for production

## Troubleshooting

- Ensure all dependencies are installed
- Verify Cloudflare API key permissions
- Check network connectivity
- Review log files for detailed error messages

## License

[Specify your license here]

## Contributing

Contributions are welcome! Please submit pull requests or open issues on the repository.
