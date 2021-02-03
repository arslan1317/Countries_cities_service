function AgentReports(opts){
    this.name = 'agent_reports';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS from user_roles #WHERE',
            name: 'fetch-users-id',
            simple_name: 'get_user_id',
        },
        {
            text: `SELECT COUNT(DISTINCT( im.customer_id)) AS count FROM inbound_messages im #WHERE`,
            name: 'fetch-engagement-stats',
            simple_name: 'get_engagement_stats',
        },
        {
            text: `SELECT COUNT( im.customer_id ) AS count FROM inbound_messages im #WHERE`,
            name: 'fetch-chat-report',
            simple_name: 'get_conversation_report',
        },
        {
            text: `SELECT im.received_at AS incoming, om.dt AS outgoing FROM inbound_messages im LEFT JOIN outbound_messages om ON im.customer_id = om.receiver_id #WHERE GROUP BY im.received_at, om.dt ORDER BY om.dt`,
            name: 'fetch-chat-report',
            simple_name: 'get_chat_report',
        },
        {
            text: 'SELECT COUNT(user_id) from user_roles #WHERE',
            name: 'fetch-users-count',
            simple_name: 'get_users_count',
        },
    ];

};

module.exports = AgentReports;