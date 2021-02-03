function ClientSettings() {

    this.name = 'client_settings';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM clients AS CL LEFT JOIN client_settings AS CLS ON CLS.client_id = CL.id LEFT JOIN settings AS STT ON STT.id = CLS.setting_id #WHERE',
            name: 'get-client-settings',
            simple_name: 'fetch',
        }
    ];

};

module.exports = ClientSettings;