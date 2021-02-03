const logger  = require('pino')();

const di = require('./src/globals/di');
const config = require('./src/globals/config');
const adapters = require('./src/adapters')(logger, config);

const init = async function init() {
    const _di = di({
        logger,
        config,
        adapters
    });

    const { modelResolver, jobScheduler } = _di._container().cradle;

    try {
        modelResolver.load();
        await jobScheduler.init(true);
    } catch (err) {
        console.error(`Job scheduler initialization error > `, err);
        logger.error(`Job scheduler initialization error > `, err);
    } 

};

init();