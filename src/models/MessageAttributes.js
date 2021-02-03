function MessageAttributes() {

    this.name = 'message_attributes';
    
    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM inbound_attachment_attributes #WHERE',
            name: 'inbound-attachement-attributes',
            simple_name: 'inbound_attachments'
        },
        {
            text: 'SELECT #COLUMNS FROM outbound_attachment_attributes #WHERE',
            name: 'outbound-attachement-attributes',
            simple_name: 'outbound_attachments'
        }
    ];

};

module.exports = MessageAttributes;