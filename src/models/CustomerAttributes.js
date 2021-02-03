function CustomerAttributes() {
    this.name = 'customer_attributes';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO customer_attributes (attribute_type, attribute_name, attribute_value, customer_id, "order", dt) VALUES ($1, $2, $3, $4, $5, NOW()) #RETURNING',
            name: 'create-attribute',
            simple_name: 'create_attribute'
        },
        {
            text: 'SELECT #COLUMNS FROM customer_attributes #WHERE',
            name: 'fetch-attributes',
            simple_name: 'fetch'
        },
        {
            text: 'UPDATE customer_attributes SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update-attributes',
            simple_name: 'update'
        }
    ];
};

module.exports = CustomerAttributes;