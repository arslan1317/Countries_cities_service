function CountriesHandlerSchema(opts) {

    const { countriesHandlers, countriesSchemaParameters, commonRequestParameters} = opts;
    
    this.fetch = () => {
        return {
            method: 'GET',
            url: '/fetch/countries',
            handler: countriesHandlers.fetch
        };
    };

};

module.exports = CountriesHandlerSchema;


