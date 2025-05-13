# Data Residency Example

This project demonstrates the implementation of dual OmniAuth provider configurations for GitHub authentication, supporting both standard GitHub.com and GitHub Enterprise Cloud (GHE) instances for data residency requirements.

## Prerequisites

- Ruby 3.4.3
- OAuth API credentials:
  - GitHub.com API keys
  - GitHub Enterprise API keys for your organization (`<subdomain>.ghe.com`)
- A public-facing domain for OAuth callbacks
  - Recommended tunnel solutions:
    - ngrok
    - Tailscale Funnel
    - Cloudflare Tunnel

## Configuration

1. Create and configure environment variables:

   ```bash
   cp .env.example .env
   ```

   Update the `.env` file with your OAuth credentials.

2. Configure Bundler to access the Packfiles gem registry:

   ```bash
   bundle config https://rubygems.pkg.github.com/packfiles USERNAME:personal_access_token_with_registry_access
   ```

3. Initialize the project:

   ```bash
   bin/setup
   ```

4. Set up a tunnel for local development:

   ```bash
   tailscale funnel 3000
   ```

## Development Environment

Update `config/environments/development.rb` with your tunnel hostname(s) to enable OAuth callback functionality.


## Demo

https://github.com/user-attachments/assets/a37f3277-e88b-4523-ab5e-77ad174720c0

---

Made with :heart: by [Packfiles :package:](https://packfiles.io)
