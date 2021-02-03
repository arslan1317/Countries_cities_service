function MessageStates() {
    this.name = 'message_states';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO message_states (state_text, default_state, state_hash) VALUES ($1, $2, $3) #RETURNING',
            name: 'insert-message-states',
            simple_name: 'new_message_states',
        },
        {
            text: 'UPDATE message_states SET #COLUMNS  #WHERE',
            name: 'update-message-states',
            simple_name: 'update_message_states',
        },
        {
            text: 'SELECT #COLUMNS FROM message_states #WHERE',
            name: 'fetch-message-states',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT #COLUMNS FROM message_states #WHERE',
            name: 'select-message-states-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = MessageStates;