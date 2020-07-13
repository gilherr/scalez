const pgPromise = require('pg-promise');

const initOptions = {}
const pgp = pgPromise(initOptions);

const {
    DB_USER: user,
    DB_PASSWORD: password,
    DB_HOST: host,
    DB_PORT: port,
    DB_NAME: dbName,
} = process.env;

const db = pgp(`postgres://${user}:${password}@${host}:${port}/${dbName}`);

module.exports = db;