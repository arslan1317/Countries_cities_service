function CitiesHandlerSchema(opts) {

    const { citiesHandlers, commonRequestParameters, citiesSchemaParameters } = opts;

    this.getStatesById = () => {
        return {
            method: 'GET',
            url: '/fetch/states/:country_id',
            handler: citiesHandlers.getStatesById,
        }
    };

    this.getCitiesById = () => {
        return {
            method: 'GET',
            url: '/fetch/cities/:state_id',
            handler: citiesHandlers.getCitiesById,
        }
    };

    
};

module.exports = CitiesHandlerSchema;


