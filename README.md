# Project Management System

A robust RESTful API backend for managing projects and tasks. This application allows users to create, update, and track projects and their associated tasks through a secure API.

# Detailed task description

**GitHub:** [pilot/blob/develop/TASK_DEFINITION.md](pilot/blob/develop/TASK_DEFINITION.md)

## Repository

**GitHub:** [pilot](pilot)

## Project

**GitHub:** [projects/11](projects/5)

## Features

- User authentication with simple token
- Project CRUD operations
- Task management with status tracking
- RESTful API design
- Optimized database queries
- Comprehensive test coverage
- API documentation with Swagger

## Requirements

- Ruby 3.3.6
- Rails 7.2.2+
- PostgreSQL
- Docker (optional)

## Local Setup

1. Install dependencies

   ```
   bundle install
   ```

2. Setup environment variables

   ```
   cp .env.example .env
   # Edit .env file with your database credentials
   ```

3. Setup git hooks (optional)

   ```
   overcommit --sign
   ```
   
4.Setup database

   ```
   rails db:create
   rails db:migrate
   rails db:seed # Optional - adds sample data
   ```

5. Start the server

   ```
   rails s -p 3000
   ```

6. Access the API at http://localhost:3000

## Docker Setup

1. Build and start the containers

   ```
   docker compose build
   docker compose up
   ```

2. Setup the database
   ```
   docker compose run app rails db:create
   docker compose run app rails db:environment:set RAILS_ENV=development
   docker compose run app rake db:schema:load
   docker compose run app rails db:seed # Optional
   ```

## Docker Commands

```
# Migration commands
docker exec -it pilot-app-1 rails g migration description_of_change
docker exec -it pilot-app-1 rails db:migrate
docker exec -it pilot-app-1 rails db:rollback

# Bundle commands
docker compose run app bundle update
docker compose run app bundle

# Other helpful commands
docker exec -it pilot-app-1 rails c      # Rails console
docker attach pilot-app-1                # Debug mode
docker exec -it pilot-app-1 rspec        # Run tests
docker exec -it pilot-app-1 /bin/bash    # Terminal access
```

## API Documentation

The API is documented using Swagger/OpenAPI. After starting the server, you can access the documentation at:

```
http://localhost:3000/api-docs/index.html
```

To regenerate the Swagger documentation:

```
RAILS_ENV=test bundle exec rspec spec/requests/api/v1 --format Rswag::Specs::SwaggerFormatter
```

## API Endpoints

- **Authentication**

  - POST /api/v1/auth/login - Sign in
  - POST /api/v1/users - Register a new user

- **Projects**

  - GET /api/v1/projects - List all projects
  - GET /api/v1/projects/:id - Get project details
  - POST /api/v1/projects - Create a new project
  - PUT /api/v1/projects/:id - Update a project
  - DELETE /api/v1/projects/:id - Delete a project

- **Tasks**
  - GET /api/v1/projects/:project_id/tasks - List tasks for a project with filter
  - GET /api/v1/tasks/:id - Get task details
  - POST /api/v1/projects/:project_id/tasks - Create a new task
  - PUT /api/v1/tasks/:id - Update a task
  - DELETE /api/v1/tasks/:id - Delete a task

## CURL example

``` Register a new user
curl -X 'POST' \
  'http://localhost:3000/api/v1/users' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user": {
    "email": "user@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
}'
```

```Sign in
curl -X 'POST' \
  'http://localhost:3000/api/v1/sign_in' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "email": "user@example.com",
  "password": "password"
}'
```

```Project list

curl -X 'GET' \
  'http://localhost:3000/api/v1/projects' \
  -H 'accept: application/json' \
  -H 'X-User-Token: <X_USER_TOKEN>' \
  -H 'X-User-Email: <X_USER_EMAIL>'
```

## Running Tests

```
bundle exec rspec
```

## Troubleshooting

If you get an error "A server is already running", try:

```
rm tmp/pids/server.pid
```

Then start the server again.

```

```
