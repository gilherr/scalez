const funnel = require('express').Router();
const db = require('../db/DBService')

funnel.put('/rate', async (req, res) => {
    const {productId, like} = req.query;

    if(!productId || !like){
        res.status(500).json({error: 'missing required params'});
    }

    try {
        await db.rateProduct(productId, req.userMetaCookie.userId, like);
        res.status(200).send();
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to rate product'});
    }
});

funnel.get('/getProducts', async (req, res) => {

    const {productsShow} = req.query;

    try {
        const seenProductsIds = await db.seenProductsIds(req.userMetaCookie.userId);
        const products = await db.getProducts(productsShow, seenProductsIds);
        res.status(200).json(products);
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to get products'});
    }
});

funnel.get('/finished', async (req, res) => {

    try {
        await db.setUserIsNewStatus(req.userMetaCookie.userId, false);
        res.status(200).send();
    } catch (e) {
        console.error(e)
        res.status(500).json({error: 'failed to set user info'});
    }
});

module.exports = funnel;