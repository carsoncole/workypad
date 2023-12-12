# WorkyPad

This is a Ruby on Rails application for managing job prospecting, utilizing Hotwire and Stimulus.


## Installation

This is configured for Ruby 3.2, Ruby on Rails 7.1 and PostgreSQL with [Kamal](https://github.com/basecamp/kamal), and [config/deploy.yml](/config/deploy.yml) should be configured for your host(s) and it can be hosted either in the cloud or baremetal, all you need is a server instance with SSH access. Kamal will take care of the rest, installing docker, Traefik for routing, and PostrgreSQL for the database.

Remove or replace my BuyMeACoffee button link at `views/public/pricing.html.erb`



***

## Quick Start

Configure ```config/deploy.yml``` with your own host and registry info. Passwords will need to be added to ```/.env ```.

You will need a domain name for your app and access to its DNS records. Adjust the DNS A records to point to your new host IP.

SSH into your host and set up it to handle the ACME validation step for Lets Encrypt, which will be providing your SSL certificate (for free).

```
  mkdir -p /letsencrypt && touch /letsencrypt/acme.json && chmod 600 /letsencrypt/acme.json
```

To deploy for the first time:

```ruby
  kamal setup
```

This will install Docker, and then the app, Traefik and PostgreSQL in separate containers on your host.

You can check the deploy status with:

```ruby
  kamal detail
```

And for later deploys, as you make additional changes, this will just deploy the code:

```ruby
  kamal deploy
```



***

## Licensing

WorkyPad is Copyright © 2023 Carson Cole. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
