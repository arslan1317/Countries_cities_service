function CitiesHandlers(opts) {

  const { citiesService } = opts;

  this.getStatesById = async function getStatesById(request, reply) {
      const { params } = request;

      const country_id = params;

      const states = await citiesService.byCountryId(country_id);

      reply.send({
          states
      })
  }

  this.getCitiesById = async function getCitiesById(request, reply) {
    const { params } = request;

    const state_id = params;

    const cities = await citiesService.byStateId(state_id);

    reply.send({
        cities
    })
  }
};

module.exports = CitiesHandlers;