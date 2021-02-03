function Reports(opts){
    this.name = 'reports';

    this.queries = {};

    this.sql = [
        {
            text: `SELECT COUNT(id),CAST('outgoing' AS VARCHAR(8)) AS direction FROM outbound_messages WHERE DATE(dt) BETWEEN $1 AND $2 UNION ALL SELECT COUNT(id), CAST('incoming' AS VARCHAR(8)) AS direction FROM inbound_messages WHERE DATE(received_at) BETWEEN $1 AND $2`,
            name: 'fetch-chat-report',
            simple_name: 'get_chat_stats',
        },
        {
            text: `SELECT COUNT(DISTINCT( im.customer_id)) FROM inbound_messages im LEFT JOIN outbound_messages om ON im.customer_id = om.receiver_id #WHERE`,
            name: 'fetch-engagement-stats',
            simple_name: 'get_engagement_stats',
        },
        {
            text: `SELECT #COLUMNS FROM inbound_messages im LEFT JOIN outbound_messages om ON im.customer_id = om.receiver_id #WHERE`,
            name: 'fetch-chat-report',
            simple_name: 'get_chat_report',
        },
        {
            text: `SELECT COUNT(DISTINCT( im.number)) AS count FROM inbound_messages im LEFT JOIN outbound_messages om ON im.customer_id = om.receiver_id #WHERE GROUP BY im.number, DATE(im.received_at), DATE(om.dt) ORDER BY DATE(om.dt) DESC`,
            name: 'fetch-chat-report',
            simple_name: 'get_count',
        }
    ];

};

module.exports = Reports;