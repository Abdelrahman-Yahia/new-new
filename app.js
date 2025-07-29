const express = require('express');
const cors = require('cors');
require('dotenv').config();
const pool = require('./config/db');

const app = express();

app.use(cors());
app.use(express.json());

// Check database schema at startup
pool.query(`
  SELECT column_name, data_type 
  FROM information_schema.columns 
  WHERE table_name = 'users'
`).then(result => {
  console.log('Users table schema:');
  console.table(result.rows);
}).catch(err => {
  console.error('Error fetching schema:', err);
});

const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const taskRoutes = require('./routes/taskRoutes');

app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/tasks', taskRoutes); // Updated to match frontend API calls

app.get('/', (req, res) => {
  res.send('Task Management API is running');
});

const PORT = 5000;

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

module.exports = app;