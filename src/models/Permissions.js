function Permissions() {
    this.name = 'permissions';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO permissions (method, description, rule_set, consumer, title, enabled, displayed, dt) VALUES ($1, $2, $3, $4, $5,$6,$7, NOW()) #RETURNING',
            name: 'insert-permission',
            simple_name: 'new_permission',
        },
        {
            text: 'UPDATE permissions SET #COLUMNS #WHERE',
            name: 'update-permission',
            simple_name: 'update_permission',
        },
        {
            text: 'SELECT #COLUMNS FROM permissions #WHERE',
            name: 'fetch-permissions',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(id) FROM permissions #WHERE',
            name: 'fetch-permissions-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM permissions #WHERE',
            name: 'select-permission-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE permissions SET #COLUMNS #WHERE',
            name: 'update-permission-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM permissions #WHERE',
            name: 'select-permissions-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = Permissions;