function States() {
    this.name = 'states';
    
    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM states #WHERE',
            name: 'fetch-states',
            simple_name: 'get_states',
        }
    ];
};

module.exports = States;