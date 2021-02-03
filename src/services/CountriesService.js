function CountriesService(opts) {

    const { query } = opts;

    this.fetch = async function fetch() {

        const countries = await query.final([
            'countries',
            'get_countries',
            undefined,
            undefined,
            'id, name'
        ]);

        return countries;
    };

};

module.exports = CountriesService;