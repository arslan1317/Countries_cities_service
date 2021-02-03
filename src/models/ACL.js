function ACL() {
    this.name = 'acl';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT PRM.method, PRM.rule_set FROM user_roles AS USR LEFT JOIN role_permissions AS RP ON RP.role_id = USR.role_id LEFT JOIN permissions AS PRM ON PRM.id = RP.permission_id WHERE USR.user_id = $1 AND consumer = $2',
            name: 'consumer-permissions',
            simple_name: 'consumer_permissions',
        },
        {
            text: 'SELECT PRM.method, PRM.rule_set FROM user_roles AS USR LEFT JOIN role_permissions AS RP ON RP.role_id = USR.role_id LEFT JOIN permissions AS PRM ON PRM.id = RP.permission_id WHERE USR.user_id = $1',
            name: 'user-permissions',
            simple_name: 'user_permissions',
        }
    ];
}

module.exports = ACL;