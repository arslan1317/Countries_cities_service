const ioredis = require('ioredis');

module.exports = (logger, config) => {
    const options = config.get('storage').redis;

    const redis = new ioredis(options.port, options.host);

    redis.on('connect', () => {
        logger.info('[\u2713] Redis [connected]');
    });

    redis.ping().then(() => {
        logger.info('[\u2713] Redis [ready]');
    });
    
    return redis;
};