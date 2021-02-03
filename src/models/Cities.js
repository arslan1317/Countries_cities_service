function Cities() {
    this.name = 'cities';
    
    this.queries = {};

    this.sql = [
        {
            text:'SELECT COUNT(id) FROM cities #WHERE',
            name:'fetch-campaign',
            simple_name: 'get_count'
        },
        {
            text: 'SELECT #COLUMNS FROM cities #WHERE',
            name: 'fetch-cities',
            simple_name: 'get_list',
        },
        {
            text: 'INSERT INTO cities (name, code, country_id, enabled, creator, client_id, dt) VALUES ($1, $2, $3, $4, $5, $6, NOW()) #RETURNING',
            name: 'create-city',
            simple_name: 'create',
        },
        {
            text: 'SELECT #COLUMNS FROM cities #WHERE',
            name: 'fetch-cities',
            simple_name: 'get_cities',
        },
        {
            text: 'UPDATE cities SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update_cities',
            simple_name: 'update',
        }
    ];
};

module.exports = Cities;