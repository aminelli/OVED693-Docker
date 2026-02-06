const e = require('express');
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware per il parsing json
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Route principale
app.get('/', (req, res) => {
    res.json({
        message: 'Server is running',
        timestamop: new Date().toISOString()
    });
});


// Route di esempio
app.get('/api/users', (req, res) => {
    const users = [
        { id: 1, name: 'Alice', email: 'alice@example.com' },
        { id: 2, name: 'Bob', email: 'bob@example.com' },
        { id: 3, name: 'Charlie', email: 'charlie@example.com' }
    ];
    res.json(users);
});


// Route di esempio - Info
app.get('/api/info', (req, res) => {
    res.json({
        app: 'Esercizio DEV 001',
        version: '1.0.0',   
        platform: process.platform,
        nodeVersion: process.version,
        uptime: process.uptime(),
        memoryUsage: process.memoryUsage(),
        cpuUsage: process.cpuUsage()
    });
});

// Health check route
app.get('/health', (req, res) => {
    res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Something went wrong!' });
});

// Avvio del server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    console.log(`Ambiente: ${process.env.NODE_ENV || 'development'}`);
});