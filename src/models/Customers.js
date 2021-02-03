function Customers() {
    this.name = 'customers';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO customers (name, number, client_id, chat_id, dt) VALUES ($1, $2, $3, $4, NOW()) #RETURNING',
            name: 'insert-customer',
            simple_name: 'create_customer',
        },
        {
            text: 'SELECT #COLUMNS FROM customers #WHERE',
            name: 'get-customer',
            simple_name: 'get_list',
        },
        {
            text: 'UPDATE customers SET #COLUMNS #WHERE #RETURNING',
            name: 'update-customer',
            simple_name: 'update_customer',
        },
        {
            text: 'SELECT COUNT(id) FROM customers #WHERE',
            name: 'fetch-customer',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM customers #WHERE',
            name: 'select-customers-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE customers SET #COLUMNS #WHERE',
            name: 'update-customer-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM customers #WHERE',
            name: 'select-customers-report',
            simple_name: 'get_report'
        },
        {
            text: 'SELECT id,name,number, dtu FROM customers t1 WHERE NOT EXISTS (SELECT dtu FROM customers t2 WHERE t2.dtu > t1.dtu) AND user_id = $1 AND client_id = $2',
            name: 'select-latest-customer-message',
            simple_name: 'get_latest_message'
        }
    ];
};

module.exports = Customers;