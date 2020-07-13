const closet = require('express').Router();

closet.get('/', (req, res) => {
    res.status(200).json({ message: 'not implemented' });;
});

module.exports = closet;