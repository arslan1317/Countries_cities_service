function WtMessages() {

    this.name = 'wt_messages';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO outbound_messages (sender_id, client_id, message_id, message_body, message_status, receiver, receiver_id, message_type, group_id, campaign_id, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW()) #RETURNING',
            name: 'insert-outbound',
            simple_name: 'create_outbound_message',
        },
        {
            text: 'SELECT COUNT(id) FROM outbound_messages',
            name: 'fetch-outobund-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM outbound_messages #WHERE',
            name: 'fetch-outbound',
            simple_name: 'get_list'
        },
        {
            text: 'SELECT #COLUMNS FROM outbound_messages #WHERE',
            name: 'select-outbound-messages-report',
            simple_name: 'get_report'
        },
        {
            text: 'UPDATE outbound_messages SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update-outbound-message',
            simple_name: 'update_message',
        },
        {
            text: 'INSERT INTO outbound_attachments (attachment_type, message_id, dt) VALUES ($1, $2, NOW()) #RETURNING',
            name: 'insert-outbound-attachment',
            simple_name: 'create_attachment',

        },
        {
            text: 'INSERT INTO outbound_attachment_attributes (attribute_value, attribute_type, attribute_name, attachment_id, dt) VALUES ($1, $2, $3, $4, NOW()) #RETURNING',
            name: 'insert-outbound-attachment-attrs',
            simple_name: 'create_attachment_attributes',  
        },
        {
            text: 'INSERT INTO outbound_customer_contacts (name, number, whatsapp_enabled, attachment_id, message_id, customer_id, user_id, group_id, contact_type, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) #RETURNING',
            name: 'insert-outbound-customer-contact',
            simple_name: 'create_outbound_contact',
        }
    ];
};

module.exports = WtMessages;