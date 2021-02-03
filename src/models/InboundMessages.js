function InboundMessages(opts) {

    this.name = 'inbound_messages';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO inbound_messages (message_id, number, type, message_body, receiver, user_id, client_id, customer_id, group_id, received_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) #RETURNING',
            name: 'insert-inbound-message',
            simple_name: 'create_inbound_message',
        },
        {
            text: 'INSERT INTO inbound_messages (message_id, number, type, message_body, receiver, user_id, client_id, customer_id, group_id, received_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) #RETURNING',
            name: 'insert-group-message',
            simple_name: 'create_group_message',
        },
        {
            text: 'SELECT #COLUMNS FROM inbound_messages #WHERE',
            name: 'fetch-inbound-messages',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT #COLUMNS FROM inbound_messages #WHERE',
            name: 'select-inbound-messages-report',
            simple_name: 'get_report'
        },
        {
            text: 'UPDATE inbound_messages SET #COLUMNS #WHERE',
            name: 'update-inbound-messages',
            simple_name: 'update_inbound_messages',
        },
        {
            text: 'SELECT COUNT(id) FROM inbound_messages',
            name: 'fetch-inbound-messages',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM inbound_messages #WHERE',
            name: 'select-inbound-message-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE inbound_messages SET #COLUMNS #WHERE',
            name: 'update-inbound_message-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'INSERT INTO inbound_attachments (attachment_type, message_id, dt) VALUES ($1, $2, NOW()) #RETURNING',
            name: 'insert-inbound-attachment',
            simple_name: 'create_attachment',

        },
        {
            text: 'INSERT INTO inbound_attachment_attributes (attribute_value, attribute_type, attribute_name, attachment_id,  dt) VALUES ($1, $2, $3, $4, NOW()) #RETURNING',
            name: 'insert-inbound-attachment-attrs',
            simple_name: 'create_attachment_attributes',  
        },
        {
            text: 'INSERT INTO inbound_customer_contacts (name, number, whatsapp_enabled, attachment_id, message_id, customer_id, user_id, group_id, contact_type, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) #RETURNING',
            name: 'insert-inbound-customer-contact',
            simple_name: 'create_inbound_contact',
        }
    ];

};

module.exports = InboundMessages;