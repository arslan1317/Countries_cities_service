function UserRoles() {

    this.name = 'user_roles';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO user_roles (user_id, role_id) VALUES ($1, $2)',
            name: 'insert-user-roles',
            simple_name: 'assign_role',
        },
        {
            text: 'UPDATE user_roles SET #COLUMNS #WHERE',
            name: 'update-user-roles',
            simple_name: 'update_user_roles',
        },
        {
            text: 'SELECT #COLUMNS FROM user_roles #WHERE',
            name: 'fetch-user-roles',
            simple_name: 'get_user_roles',
        },
        {
            text: 'DELETE FROM user_roles #WHERE',
            name: 'delete-user-roles',
            simple_name: 'remove_user_roles',
        }
    ];
};

module.exports = UserRoles;