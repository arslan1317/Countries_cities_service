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

    const { modelResolver, campaignTasksService } = _di._container().cradle;

    if (config.get().env === 'debug') {
        await campaignTasksService.sendOutboundMessages(process.argv[2], process.argv[3], process.argv[4],process.argv[5],process.argv[6]);
        //await campaignTasksService.sendOutboundMessages(process.argv[4], process.argv[5], process.argv[6],process.argv[7],process.argv[8]);
    } else {
        await campaignTasksService.sendOutboundMessages(process.argv[2], process.argv[3], process.argv[4],process.argv[5],process.argv[6]);
    }
};

init();