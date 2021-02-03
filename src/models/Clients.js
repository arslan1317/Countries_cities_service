function Clients() {
    this.name = 'clients';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO clients (host, api_key, number, uuid, enc_salt, max_token_count, enabled, bot_id, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW()) #RETURNING',
            name: 'insert-client',
            simple_name: 'new_client',
        },
        {
            text: 'SELECT #COLUMNS FROM clients #WHERE',
            name: 'fetch-client',
            simple_name: 'get_client',
        },
        {
            text: 'UPDATE clients SET #COLUMNS #WHERE',
            name: 'update-client',
            simple_name: 'update_client',
        },
        {
            text: 'SELECT #COLUMNS FROM clients #WHERE',
            name: 'fetch-client',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(id) FROM clients',
            name: 'fetch-client-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM clients #WHERE',
            name: 'select-client-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE clients SET #COLUMNS #WHERE',
            name: 'update-client-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM clients #WHERE',
            name: 'select-clients-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = Clients;