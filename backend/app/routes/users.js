const users = require('express').Router();

users.get('/', (req, res) => {
    res.status(200).json({ message: 'not implemented' });
});

module.exports = users;