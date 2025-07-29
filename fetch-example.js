/**
 * Fetch API Examples for TaskMate Backend
 * This file contains examples of using the Fetch API to interact with the TaskMate backend
 */

// Get the authentication token from localStorage
const getToken = () => localStorage.getItem('token');

// Example 1: Login
async function loginUser(email, password) {
  try {
    const response = await fetch('http://localhost:5000/api/auth/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email, password })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    // Store token and user data
    localStorage.setItem('token', data.token);
    localStorage.setItem('currentUser', JSON.stringify(data.user));
    return data;
  } catch (error) {
    console.error('Login error:', error);
    throw error;
  }
}

// Example 2: Get all tasks
async function fetchTasks() {
  try {
    const response = await fetch('http://localhost:5000/api/task', {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${getToken()}`
      }
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching tasks:', error);
    throw error;
  }
}

// Example 3: Create a new task
async function createTask(taskData) {
  try {
    const response = await fetch('http://localhost:5000/api/task', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify(taskData)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error creating task:', error);
    throw error;
  }
}

// Example 4: Update a task
async function updateTask(taskId, taskData) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify(taskData)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error updating task:', error);
    throw error;
  }
}

// Example 5: Delete a task
async function deleteTask(taskId) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}`, {
      method: 'DELETE',
      headers: {
        'Authorization': `Bearer ${getToken()}`
      }
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error deleting task:', error);
    throw error;
  }
}

// Example 6: Update task status
async function updateTaskStatus(taskId, newStatus) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}/status`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify({ status: newStatus })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error updating task status:', error);
    throw error;
  }
}

// Example 7: Share a task with other users
async function shareTask(taskId, users) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}/share`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify({ users })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error sharing task:', error);
    throw error;
  }
}

// Example 8: Get task comments
async function getTaskComments(taskId) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}/comments`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${getToken()}`
      }
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching task comments:', error);
    throw error;
  }
}

// Example 9: Add a comment to a task
async function addTaskComment(taskId, commentText) {
  try {
    const response = await fetch(`http://localhost:5000/api/task/${taskId}/comments`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify({ text: commentText })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error adding comment:', error);
    throw error;
  }
}

// Example 10: Get notifications
async function getNotifications() {
  try {
    const response = await fetch('http://localhost:5000/api/task/notifications', {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${getToken()}`
      }
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching notifications:', error);
    throw error;
  }
}

// Example 11: Register a new user
async function registerUser(userData) {
  try {
    const response = await fetch('http://localhost:5000/api/auth/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(userData)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Registration error:', error);
    throw error;
  }
}

// Example 12: Update user profile
async function updateUserProfile(userId, profileData) {
  try {
    const response = await fetch(`http://localhost:5000/api/user/${userId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${getToken()}`
      },
      body: JSON.stringify(profileData)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error updating profile:', error);
    throw error;
  }
}

// Example usage:
// loginUser('john@example.com', 'password')
//   .then(data => console.log('Login successful:', data))
//   .catch(error => console.error('Login failed:', error));

// fetchTasks()
//   .then(tasks => console.log('Tasks:', tasks))
//   .catch(error => console.error('Failed to fetch tasks:', error)); 