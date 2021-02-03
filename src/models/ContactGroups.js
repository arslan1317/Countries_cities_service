function ContactGroups() {
    this.name = 'contact_groups';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO contact_groups (title, description, user_id, creator, client_id, dt) VALUES ($1, $2, $3, $4, $5, NOW()) #RETURNING',
            name: 'insert-contact-groups',
            simple_name: 'new_contact_groups',
        },
        {
            text: 'SELECT #COLUMNS FROM contact_groups #WHERE',
            name: 'fetch-contact-group',
            simple_name: 'get_contact_groups',
        },
        {
            text: 'UPDATE contact_groups SET #COLUMNS #WHERE',
            name: 'update-contact-groups',
            simple_name: 'update_contact_groups',
        },
        {
            text: 'SELECT #COLUMNS FROM contact_groups CG #WHERE',
            name: 'fetch-contact-groups',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(CG.id) FROM contact_groups CG #WHERE',
            name: 'fetch-contact-groups-count',
            simple_name: 'get_count',
        }
    ];
};

module.exports = ContactGroups;