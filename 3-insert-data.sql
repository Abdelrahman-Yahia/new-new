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