function WtGroups() {

    this.name = 'wt_groups';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO conversation_groups (group_id, creator, client_id, group_icon, user_id, subject, dt) VALUES ($1, $2, $3, $4, $5, $6, NOW()) #RETURNING',
            name: 'insert-group',
            simple_name: 'create_group'
        },
        {
            text: 'UPDATE conversation_groups SET #COLUMNS #WHERE #RETURNING',
            name: 'update-group',
            simple_name: 'update_group',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_groups #WHERE',
            name: 'fetch-group',
            simple_name: 'get_list'
        },
        {
            text: 'SELECT COUNT(id) FROM conversation_groups #WHERE',
            name: 'fetch-conversation-groups',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_groups #WHERE',
            name: 'select-conversation-groups-report',
            simple_name: 'get_report'
        },
        {
            text: 'SELECT id, subject, group_icon, group_id, dtu FROM conversation_groups t1 WHERE NOT EXISTS (SELECT dtu FROM conversation_groups t2 WHERE t2.dtu > t1.dtu) AND user_id = $1',
            name: 'select-latest-group-message',
            simple_name: 'get_latest_group'
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_groups, json_array_elements(group_members) #WHERE',
            name: 'select-group-members-count',
            simple_name: 'get_members_count'
        }
    ];

};

module.exports = WtGroups;