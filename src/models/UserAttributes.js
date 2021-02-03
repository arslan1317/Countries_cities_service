function UserAttributes(){

    this.name = 'user_attributes';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM user_attributes #WHERE',
            name: 'fetch-user-attributes',
            simple_name: 'fetch'
        },
        {
            text:'INSERT INTO user_attributes (attribute_type, attribute_name, attribute_value, user_id, "order", dt) VALUES ($1, $2, $3, $4,$5, NOW()) #RETURNING',
            name:'insert-user-attributes',
            simple_name:'create'
        },
        {
            text:'UPDATE user_attributes SET #COLUMNS, dtu = NOW() #WHERE',
            name:'update-user-attributes',
            simple_name:'update'
        }
    ];

};

module.exports = UserAttributes;