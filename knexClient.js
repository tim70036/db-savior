const Knex = require('knex');
const dotenv = require('dotenv');

dotenv.config();

const knexClient = Knex({
    client: 'mysql',
    connection: {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PWD,
        database: process.env.DB_NAME,
        timezone: 'Z'
    },

    // Stack trace capture for all query builders, raw queries and schema builders.
    // This has small performance overhead, so it is advised to use only for development.
    asyncStackTraces: false,

    // Connection pool.
    pool: {
        min: 0,
        max: 10,

        // This is called when the pool aquires a new connection from the database server.
        // Also, done(err, connection) callback must be called for knex to be able to decide if the connection is ok or it should be discarded.
        afterCreate: function (conn, done) {
            done(null, conn);
        },
    },

    // How long (in ms) knex should wait before throwing a timeout error when acquiring a connection is not possible.
    // Could happen if all connections in pool are being used.
    acquireConnectionTimeout: 60000,
});

module.exports = { knexClient };
