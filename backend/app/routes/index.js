const routes = require('express').Router();
const users = require('./users')
const funnel = require('./funnel')
const closet = require('./closet')
const abtest = require('./abtest')

routes.get('/', (req, res) => {
    res.status(200).json({ message: 'not implemented' });
});

routes.use('/users', users);
routes.use('/funnel', funnel);
routes.use('/closet', closet);
routes.use('/abtest', abtest);

module.exports = routes;