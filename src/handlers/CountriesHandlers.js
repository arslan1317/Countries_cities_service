function CountriesHandlers(opts) {

    const { countriesService } = opts;

    this.fetch = async function fetch(request, reply) {

        const countries = await countriesService.fetch();

        reply.send({
            countries
        })
    }

};

module.exports = CountriesHandlers;