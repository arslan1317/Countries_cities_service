function Countries() {
    this.name = 'countries';
    
    this.queries = {};

    this.sql = [
        {
            text:'SELECT COUNT(id) FROM countries #WHERE',
            name:'fetch-campaign',
            simple_name: 'get_count'
        },
        {
            text: 'SELECT #COLUMNS FROM countries #WHERE',
            name: 'fetch-countries',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT #COLUMNS FROM countries #WHERE',
            name: 'fetch-countries',
            simple_name: 'get_countries',
        },
        {
            text: 'INSERT INTO countries (name, code, client_id, enabled, creator, dt) VALUES ($1, $2, $3, $4, $5, NOW()) #RETURNING',
            name: 'insert-country',
            simple_name: 'create',
        },
        {
            text: 'UPDATE countries SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update_country',
            simple_name: 'update',
        }
    ];
};

module.exports = Countries;