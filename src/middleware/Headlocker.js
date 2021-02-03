/* eslint-disable array-callback-return */
const fp = require('fastify-plugin');

const headlocker = (fastify, opts, next) => {

    fastify.decorate('verifyApiKey', async function verifyApiKey(request, reply) {

        const { config } = this.di().cradle;

        const keys = config.get('api_keys');

        const { headers } = request;

        const api_key = headers['xt-api-key'];

        if (!keys.includes(api_key)) throw Boom.badData(`Invalid api key`);

        return;
    });

    fastify.decorate('verifyClientToken', async function verifyClientToken(request, reply) {

        const token = request.headers['xt-client-token'];

        const { client, uuid, clientTokenId } = this.jwt.verify(token);

        request.clientId = client;
        request.clientUuid = uuid;
        request.clientTokenId = clientTokenId;

        return;
    });

    fastify.decorate('verifyUserToken', async function verifyUserToken(request, reply) {

        const token = request.headers['xt-user-token'];

        const { clientUuid, client, actor, userTokenId, clientTokenId } = this.jwt.verify(token);

        request.clientId = client;
        request.userId = actor;
        request.clientUuid = clientUuid;
        request.userTokenId = userTokenId;
        request.clientTokenId = clientTokenId;

        return;
    });

    next();
};

module.exports = fp(headlocker, {
    name: 'headlocker',
    fastify: '2.x',
});