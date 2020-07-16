const express = require('express')
const routes = require('./routes');
const bodyParser = require('body-parser')
const morgan = require('morgan')
const cookieParser = require('cookie-parser');
const customMiddleWares = require('./middlewares')
const cors = require('cors')

const PORT = process.env.PORT || '3000';

// Setup express app
const app = express();
app.use(cors({credentials: true, origin: 'http://localhost:8080'}))
app.use(cookieParser());
app.use(customMiddleWares.getUserMetaFromCookie);

// Setup logger
app.use(morgan('dev'))

// Setup router
app.use('/', routes);

// Setup middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Run server
app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));