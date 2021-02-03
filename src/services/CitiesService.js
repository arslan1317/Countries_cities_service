function CitiesService(opts) {

  const { query, utilities } = opts;

 

  this.byCountryId = async function byCountryId(args) {

      const { country_id } = args;

      const byCityIdSql = query.prepare([
          'states',
          'get_states',
          [
              country_id
          ],
          undefined,
          'id, name',
          'country_id = $1'
      ]);

      const states = await query.query(byCityIdSql);

      return states;
  };

  this.byStateId = async function byStateId(args) {

    const { state_id } = args;

    const byCityIdSql = query.prepare([
        'cities',
        'get_cities',
        [
            state_id
        ],
        undefined,
        'id, name',
        'state_id = $1'
    ]);

    const cities = await query.query(byCityIdSql);

    return cities;
};


};

module.exports = CitiesService;