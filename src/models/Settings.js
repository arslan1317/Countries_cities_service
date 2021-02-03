function Settings() {
    this.name = 'settings';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO settings ( field_name, field_value, field_type, dt) VALUES ($1, $2, $3, NOW())',
            name: 'insert-settings',
            simple_name: 'create_setting',
        },
        {
            text: 'INSERT INTO #TABLE_NAME (#TYPE_ID, setting_id) VALUES ($1, $2)',
            name: 'assign-setting',
            simple_name: 'assign_setting',
        },
        {
            text: 'UPDATE settings SET #COLUMNS #WHERE',
            name: 'update-setting',
            simple_name: 'update_setting',
        },
        {
            text: 'SELECT #COLUMNS FROM settings #WHERE',
            name: 'select-settings',
            simple_name: 'get_list'
        },
        {
            text: 'SELECT COUNT(id) FROM settings',
            name: 'fetch-settings-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM settings #WHERE',
            name: 'select-setting-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE settings SET #COLUMNS #WHERE',
            name: 'update-setting-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM settings #WHERE',
            name: 'select-settings-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = Settings;