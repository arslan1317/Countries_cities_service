function Roles() {

    this.name = 'roles';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO roles (name, description, client_id, enabled, displayed, dt) VALUES ($1, $2, $3,$4,$5, NOW()) #RETURNING',
            name: 'insert-role',
            simple_name: 'new_role',
        },
        {
            text: 'UPDATE roles SET #COLUMNS #WHERE',
            name: 'update-role',
            simple_name: 'update_role',
        },
        {
            text: 'SELECT #COLUMNS FROM roles #WHERE',
            name: 'fetch-role',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(id) FROM roles #WHERE',
            name: 'fetch-roles-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM roles #WHERE',
            name: 'select-role-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE roles SET #COLUMNS #WHERE',
            name: 'update-role-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM roles #WHERE',
            name: 'select-roles-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = Roles;