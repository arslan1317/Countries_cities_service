function AutoReply() {
    this.name = 'auto_reply';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO autoreply_handles (keyword, event, message, enabled, order, dt) VALUES ($1, $2, $3, $4, $5, NOW())',
            name: 'insert-auto-reply',
            simple_name: 'create_auto_reply',
        },
        {
            text: 'SELECT #COLUMNS FROM autoreply_handles #WHERE',
            name: 'fetch-auto-reply',
            simple_name: 'get_list'
        },
    ];
}

module.exports = AutoReply;