const funnel = require('express').Router();

funnel.get('/', (req, res) => {
    res.status(200).json({ message: 'not implemented' });
});

module.exports = funnel;