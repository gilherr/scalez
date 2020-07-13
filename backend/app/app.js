const express = require('express')
const routes = require('./routes');
const bodyParser = require('body-parser')
var morgan = require('morgan')

const PORT = process.env.PORT || '3000';

// Setup express app
const app = express();

// Setup logger
app.use(morgan('common'))

// Setup router
app.use('/', routes);

// Setup middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Run server
app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));