-- Note: Run this first part separately to create the database
CREATE DATABASE "new3.4";

-- Note: After creating the database, connect to it and then run the following script:

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create tasks table
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    priority VARCHAR(20) DEFAULT 'medium',
    due_date DATE,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create tags table
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    color VARCHAR(20),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

-- Create task_tags (many-to-many relationship)
CREATE TABLE task_tags (
    task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE,
    tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (task_id, tag_id)
);

-- Create task_shares table
CREATE TABLE task_shares (
    task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    permission VARCHAR(20) DEFAULT 'view',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (task_id, user_id)
);

-- Create comments table
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create notifications table
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE,
    is_read BOOLEAN DEFAULT false,
    priority VARCHAR(20) DEFAULT 'info',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: password)
INSERT INTO users (name, email, password, role) 
VALUES ('Admin User', 'admin@example.com', '$2b$10$3euPcmQFCiblsZeEu5s7p.9wdgpt0zaCCyFdPiXxOzGI0nqWGQYp2', 'admin');

-- Insert default regular user (password: password)
INSERT INTO users (name, email, password) 
VALUES ('John Doe', 'john@example.com', '$2b$10$3euPcmQFCiblsZeEu5s7p.9wdgpt0zaCCyFdPiXxOzGI0nqWGQYp2');

-- Insert default tags
INSERT INTO tags (name, color, user_id) VALUES 
('Work', '#3B82F6', 1),
('Personal', '#10B981', 1),
('Urgent', '#EF4444', 1),
('Learning', '#8B5CF6', 1),
('Health', '#F59E0B', 1);

-- Insert sample tasks for admin
INSERT INTO tasks (title, description, status, priority, due_date, user_id)
VALUES 
('Complete Project Review', 'Review the quarterly project reports and submit feedback', 'in-progress', 'high', CURRENT_DATE + INTERVAL '2 days', 1),
('Update Documentation', 'Update the user manual with new features', 'pending', 'medium', CURRENT_DATE - INTERVAL '1 day', 1),
('Prepare Presentation', 'Create slides for the monthly team meeting', 'completed', 'low', CURRENT_DATE + INTERVAL '7 days', 1);

-- Insert sample tasks for regular user
INSERT INTO tasks (title, description, status, priority, due_date, user_id)
VALUES 
('Complete Project Proposal', 'Write and submit the project proposal for the new client', 'in-progress', 'high', CURRENT_DATE + INTERVAL '1 day', 2),
('Review Pull Requests', 'Review and merge pending pull requests from the team', 'pending', 'medium', CURRENT_DATE + INTERVAL '7 days', 2),
('Setup Development Environment', 'Install and configure the new development tools', 'completed', 'low', CURRENT_DATE - INTERVAL '2 days', 2);

-- Add tags to tasks
INSERT INTO task_tags (task_id, tag_id) VALUES 
(1, 1), (1, 3), -- Work, Urgent
(2, 1), -- Work
(3, 1), -- Work
(4, 1), (4, 4), -- Work, Learning
(5, 1), -- Work
(6, 4); -- Learning

-- Share a task between users
INSERT INTO task_shares (task_id, user_id, permission)
VALUES (1, 2, 'edit'), (5, 1, 'view');

-- Add sample comments
INSERT INTO comments (task_id, user_id, text)
VALUES 
(1, 2, 'I can help with this if needed.'),
(1, 1, 'Thanks, I''ll let you know if I need assistance.'),
(5, 2, 'Started working on this. Will complete by tomorrow.'),
(5, 1, 'Looks good so far!');

-- Add sample notifications
INSERT INTO notifications (user_id, type, title, message, task_id, priority)
VALUES 
(1, 'comment', 'New Comment', 'John Doe commented on your task "Complete Project Review"', 1, 'info'),
(2, 'due_soon', 'Task Due Soon', 'Your task "Complete Project Proposal" is due tomorrow', 4, 'warning'),
(2, 'overdue', 'Task Overdue', 'Your task "Setup Development Environment" is overdue', 6, 'urgent'); 