function Dashboard() {
    this.name = 'dashboard';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM customers #WHERE',
            name: 'fetch-consumer-box-info',
            simple_name: 'get_consumer_box_info',
        },
        {
            text: 'SELECT #COLUMNS FROM inbound_messages #WHERE',
            name: 'fetch-conversation-box-info',
            simple_name: 'get_conversation_box_info',
        }

    ];
};

module.exports = Dashboard;