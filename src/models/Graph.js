function Graph() {
    this.name = 'graph';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM inbound_messages #WHERE',
            name: 'fetch-message-stats',
            simple_name: 'get_message_stats',
        }

    ];
};

module.exports = Graph;