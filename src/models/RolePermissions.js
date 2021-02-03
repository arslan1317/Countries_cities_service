function RolePermissions() {

    this.name = 'role_permissions';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO role_permissions( permission_id, role_id) VALUES( $1, $2)',
            name: 'insert-role-permission',
            simple_name: 'new_role_permission',
        },
        {
            text: 'UPDATE role_permissions SET #COLUMNS #WHERE',
            name: 'update-role-permission',
            simple_name: 'update_role_permission',
        },
        {
            text: 'DELETE FROM role_permissions WHERE role_id = $1',
            name: 'delete-role-permission',
            simple_name: 'remove_role_permissions',
        },
        {
            text: 'SELECT #COLUMNS FROM role_permissions #WHERE',
            name: 'fetch-role-permission',
            simple_name: 'get_role_permission',
        },
        {
            text: 'SELECT #COLUMNS FROM roles AS RLS LEFT JOIN role_permissions AS RP ON RLS.id = RP.role_id LEFT JOIN permissions AS PER ON RP.permission_id = PER.id #WHERE',
            name: 'fetch-permission-roles',
            simple_name: 'fetch_role_permissions',  
        },
        {
            text: 'SELECT #COLUMNS FROM roles AS RLS LEFT JOIN role_permissions AS RP ON RLS.id = RP.role_id LEFT JOIN permissions AS PER ON RP.permission_id = PER.id WHERE RP.permission_id = $1',
            name: 'fetch-permission-roles',
            simple_name: 'fetch_permission_roles',  
        }
    ];
};

module.exports = RolePermissions;