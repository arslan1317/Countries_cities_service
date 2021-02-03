function CannedMessages() {
    this.name = 'canned_messages';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO canned_messages (message_name, message_text, message_params, client_id, attachment_url, message_type, enabled, creator, attachment_type, attachment_name, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW()) #RETURNING',
            name: 'insert-canned-message',
            simple_name: 'new_canned_message',
        },
        {
            text: 'SELECT #COLUMNS FROM canned_messages #WHERE',
            name: 'fetch-canned-message',
            simple_name: 'get_canned_message',
        },
        {
            text: 'UPDATE canned_messages SET #COLUMNS #WHERE',
            name: 'update-canned-message',
            simple_name: 'update_canned_message',
        },
        {
            text: 'SELECT #COLUMNS FROM canned_messages #WHERE',
            name: 'fetch-canned-message',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(id) FROM canned_messages #WHERE',
            name: 'fetch-canned-message-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM canned_messages #WHERE',
            name: 'select-canned-message-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE canned_messages SET #COLUMNS #WHERE',
            name: 'update-canned-message-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM canned_messages #WHERE',
            name: 'select-canned-messages-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = CannedMessages;