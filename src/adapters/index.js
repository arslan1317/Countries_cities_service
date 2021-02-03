const pgsql = require('./pgsql');
const redis = require('./redis');

module.exports = (logger, config) => ({
    db: {
        primary: pgsql(logger, config)
    },
    cache: {
        primary: redis(logger, config)
    }
});
