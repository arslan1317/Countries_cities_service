function Users() {

    this.name = 'users';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO users (username, password, email, number, client_id, enc_salt, enabled, creator, displayed, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) #RETURNING',
            name: 'insert-user',
            simple_name: 'new_user',
        },
        {
            text: 'UPDATE users SET #COLUMNS #WHERE',
            name: 'update-user',
            simple_name: 'update_user',
        },
        {
            text: 'SELECT #COLUMNS FROM users #WHERE',
            name: 'select-users',
            simple_name: 'get_list'
        },
        {
            text: 'SELECT #COLUMNS FROM users #WHERE',
            name: 'select-users-report',
            simple_name: 'get_report'
        },
        {
            text: 'SELECT COUNT(id) FROM users',
            name: 'fetch-user-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM users #WHERE',
            name: 'select-users-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE users SET #COLUMNS #WHERE',
            name: 'update-user-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM users AS USR LEFT JOIN user_roles AS USRL ON USRL.user_id = USR.id #WHERE',
            name: 'user-by-roles',
            simple_name: 'by_roles'
        }
    ];
};

module.exports = Users;