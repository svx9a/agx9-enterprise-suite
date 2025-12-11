const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(helmet());
app.use(compression());
app.use(morgan('combined'));
app.use(cors({
  origin: ['http://localhost:5173', 'http://localhost:3000'],
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    service: 'AGX9 Backend',
    version: '1.0.0'
  });
});

// ASI:One proxy endpoint
app.post('/api/chat', async (req, res) => {
  try {
    const { message, context } = req.body;
    
    // Forward to ASI:One if available
    const asiOneResponse = await fetch('http://localhost:8000/engine/run', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        prompt: message,
        suite: context || 'general',
        session_id: `session_${Date.now()}`,
        max_steps: 3
      })
    }).catch(() => null);
    
    if (asiOneResponse && asiOneResponse.ok) {
      const data = await asiOneResponse.json();
      return res.json(data);
    }
    
    // Fallback response if ASI:One is down
    res.json({
      result: `AGX9 Response: ${message}`,
      timestamp: new Date().toISOString(),
      model: 'AGX9-Fallback'
    });
    
  } catch (error) {
    console.error('Chat error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Serve static files in production
if (process.env.NODE_ENV === 'production') {
  const path = require('path');
  app.use(express.static(path.join(__dirname, '../frontend/dist')));
  
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/dist/index.html'));
  });
}

// Start server
app.listen(PORT, () => {
  console.log(`🚀 AGX9 Backend Server running on port ${PORT}`);
  console.log(`📡 Health check: http://localhost:${PORT}/api/health`);
  console.log(`💬 Chat endpoint: POST http://localhost:${PORT}/api/chat`);
});
