# Data Residency Example

This example project demonstrates how to have two OmniAuth configurations for
two different versions of GitHub, regular github.com and ghe.com for data 
residency customers.

## Requirements

- Ruby 3.4.3
- OAuth API keys for `github.com` and an organization at `<subdomain>.ghe.com`.
- add keys to your `.env` file
- a domain other than localhost for OAuth callbacks
  - localhost tunnel provider options:
    - ngrok
    - tailscale tunnel
    - cloudflare
  - update `config/environments/development.rb` with hostname(s)

## Setup

- `cp .env.example .env` and update credentials
- update bundle config to access to Packfiles gem registry
- run bin/setup
- in a separate terminal connect localhost to tunnel, e.g., `tailscale funnel 3000`