const pool = require('./config/db');

async function testDatabase() {
  try {
    console.log('Testing database connection...');
    
    // Check users table schema
    const schemaResult = await pool.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'users'
    `);
    
    console.log('Users table schema:');
    console.table(schemaResult.rows);
    
    // Test insert with all fields explicitly
    try {
      const insertResult = await pool.query(`
        INSERT INTO users (name, email, password, role, active) 
        VALUES ('Test User', 'test@example.com', 'password123', 'user', true)
        RETURNING *
      `);
      console.log('Insert successful:', insertResult.rows[0]);
    } catch (insertError) {
      console.error('Insert error:', insertError);
    }
    
    // Test select
    const selectResult = await pool.query('SELECT * FROM users LIMIT 5');
    console.log('Sample users:');
    console.table(selectResult.rows);
  } catch (error) {
    console.error('Database test error:', error);
  } finally {
    // Close the pool
    await pool.end();
  }
}

testDatabase(); 