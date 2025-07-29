# TaskMate - Task Management System

A full-stack task management application built with Node.js, Express, PostgreSQL, jQuery, and Bootstrap.

## Project Structure

- `backend/`: Express.js API server with PostgreSQL database
- `project_frontend (2)/`: Frontend application using jQuery and Bootstrap

## Prerequisites

- Node.js (v14 or higher)
- PostgreSQL database
- npm (Node Package Manager)

## Setup Instructions

### Database Setup

1. Install PostgreSQL if you haven't already
2. Run the SQL scripts in this order:
   - `1-create-database.sql`  # Creates just the database
   - `2-create-tables.sql`    # Creates the tables (after connecting to the database)
   - `3-insert-data.sql`      # Inserts the data

### Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Start the backend server
npm start
```

The backend server will run on http://localhost:5000

### Frontend Setup

```bash
# Navigate to frontend directory
cd "project_frontend (2)"

# Install dependencies
npm install

# Start the frontend server
npm start
```

The frontend will be available at http://localhost:8085

### Running Both Together

You can use the root package.json to run both services simultaneously:

```bash
# Install all dependencies (backend and frontend)
npm run install:all

# Start both servers
npm start
```

## Demo Accounts

For testing purposes, you can use these demo accounts:

- Regular User:
  - Email: john@example.com
  - Password: password

- Admin User:
  - Email: admin@example.com
  - Password: password

## Features

- User authentication (login/register)
- Task management (create, read, update, delete)
- Task filtering and sorting
- Task sharing with other users
- Calendar view
- Admin panel for user management
- Dark/light theme toggle
- Responsive design
- Auto-save functionality for all forms:
  - Task creation and editing with real-time database saving
  - Profile information updates with auto-save
  - Comment drafts saved automatically
  - Login/registration form field persistence
  - Calendar quick-add task with draft saving

## API Endpoints

### Authentication
- POST /api/auth/register - Register a new user
- POST /api/auth/login - Login a user
- GET /api/auth/verify - Verify JWT token

### Tasks
- GET /api/tasks - Get all tasks for current user
- POST /api/tasks - Create a new task
- GET /api/tasks/:id - Get a specific task
- PUT /api/tasks/:id - Update a task
- DELETE /api/tasks/:id - Delete a task
- POST /api/tasks/:id/share - Share a task with other users

### Users
- GET /api/user - Get current user profile
- PUT /api/user - Update user profile 