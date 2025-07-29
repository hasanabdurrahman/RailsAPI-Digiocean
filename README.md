# Rails API with JWT Authentication, Versioning, Serializers, and Pagination

This is a RESTful API built with Ruby on Rails that provides features such as token-based authentication using JSON Web Tokens (JWT), API versioning, data serialization, and pagination.

## Features

- **User Authentication**

  - `POST /signup`: Register a new user
  - `GET /me`: Get detail user
  - `POST /auth/login`: Authenticate a user and provide JWT token
  - `GET /auth/logout`: Logout user (invalidate token on client-side)

- **Todos Management**

  - `GET /todos`: List all todos
  - `POST /todos`: Create a new todo
  - `GET /todos/:id`: Retrieve a specific todo
  - `PUT /todos/:id`: Update a specific todo
  - `DELETE /todos/:id`: Delete a specific todo and its associated items

- **Items Management**

  - `GET /todos/:id/items`: List items for a specific todo
  - `PUT /todos/:id/items`: Update an item for a specific todo
  - `DELETE /todos/:id/items`: Delete an item from a specific todo

- **Advanced API Features**

  - **Token-based Authentication (JWT)**: Secure endpoints using JSON Web Tokens
  - **API Versioning**: Manage API versions using scoped routing (`v1` and `v2` scopes in routes)
  - **Serialization**: Manage JSON representation using ActiveModel Serializers
  - **Pagination**: Paginate API responses efficiently

### API Versioning

- **Version 1 (default)**:
  - Full CRUD functionality for todos and associated items.
- **Version 2**:
  - Initial implementation with a simpler structure (`GET /todos` returns a greeting message).

## Requirements

- Ruby (recommended: Ruby 3.0 or later)
- Ruby on Rails (recommended: Rails 8.0.2)
- SQLite database (default) or PostgreSQL

## Installation

### Clone Repository

```bash
git clone git@github.com:hasanabdurrahman/RailsAPI-Digiocean.git
cd RailsAPI-Digiocean
```

### Install Dependencies

```bash
bundle install
```

### Configure Database

```bash
rails db:create
rails db:migrate
rake db:seed
```

### Run the Application

```bash
rails s
```

The application runs by default at `http://localhost:3000`

### Running Tests

To run the full test suite:

```bash
bundle exec rspec
```

## Libraries and Frameworks (Gemfile)

Key libraries and frameworks used:

- **Rails**: Full-stack Ruby web framework (8.0.2)
- **bcrypt**: Password hashing
- **jwt**: JSON Web Tokens for secure authentication
- **ActiveModel Serializers**: Custom JSON serialization
- **will_paginate**: Efficient pagination
- **solid_cache**, **solid_queue**, **solid_cable**: Enhanced caching and background jobs
- **kamal**: Easy Docker deployment
- **thruster**: HTTP asset caching/compression for Puma
- **rspec-rails**: Testing framework for Ruby on Rails
- **faker**: Generate fake data for testing
- **factory_bot_rails**: Simplify test data setup
- **database_cleaner**: Maintain clean state between tests
- **shoulda-matchers**: Simplify Rails-specific tests
- **brakeman**: Static security analysis
- **rubocop-rails-omakase**: Ruby/Rails style checker

## API Documentation (Postman)

For ease of testing and experimenting with the API endpoints, use the following Postman workspace:

[Postman API Collection](https://hasan-1906.postman.co/workspace/RailsAPI_Digiocean~9f726aa0-c922-47d7-bd51-c0bfb415db5e/)

## Contributing

Feel free to open issues or submit pull requests for improvements.

## License

This project is open-sourced under the MIT License. See the [LICENSE](LICENSE) file for details.

