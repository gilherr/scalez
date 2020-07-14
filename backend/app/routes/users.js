const users = require('express').Router();
const db = require('../db/DBService')

users.get('/', async (req, res) => {
    try {
        const rows = await db.getAllUsers();
        res.status(200).json(rows);
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to get all users'});
    }
});

users.put('/', async (req, res) => {
    try {
        await db.createNewUser();
        res.status(200).send();
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to create user'});
    }
});

users.get('/:userId', async (req, res) => {
    try {
        const user = await db.getUser(req.params.userId)
        res.status(200).json(user);
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to get user'});
    }

});

users.get('/:userId/products', async (req, res) => {
    try {
        const user = await db.getAllProductsSeenByUser(req.params.userId)
        res.status(200).json(user);
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to get users seen products'});
    }

});



module.exports = users;