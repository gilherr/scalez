const closet = require('express').Router();
const db = require('../db/DBService')

closet.get('/', async (req, res) => {

    if(!req.userId){
        res.status(401).json({error: 'missing user info'});
    }

    try {
        const likedProducts = await db.getUserCloset(req.userId);
        res.status(200).json(likedProducts)
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to get user liked products'});
    }

});

module.exports = closet;