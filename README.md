# Playvalve API

This Rails API handles ban evaluation and integrity logging based on IDFA, VPN usage, device rooting, and country code. It uses a service-based architecture and is documented via Swagger.

## Setup

### Requirements

- Docker
- Docker Compose
- `.env` file with VPNAPI key

### Getting Started

Build and run the app using Docker:

```BASH
docker-compose up --build
```

The API will be available at:

```BASH
http://localhost:3000
```

Swagger documentation will be available at:

```BASH
http://localhost:3000/api-docs
```

### Environment Variables

Create a .env file with the following:

VPNAPI_API_KEY=your_api_key_here

This key is required to use vpnapi.io for VPN detection. You can use .env.example.

### Testing

To run the test suite:

```BASH
docker-compose exec web bundle exec rspec
```

###Linting

To run RuboCop:

```BASH
docker-compose exec web bundle exec rubocop
```
