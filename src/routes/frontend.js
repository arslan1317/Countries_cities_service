module.exports = (fastify, opts, next) => {
    const di = fastify.di();

    const {
        citiesHandlerSchema,
        countriesHandlerSchema
    } = di.cradle;

    fastify.route({ ...countriesHandlerSchema.fetch()});

    fastify.route({ ...citiesHandlerSchema.getCitiesById()});

    fastify.route({ ...citiesHandlerSchema.getStatesById()});
    
    next();
};
