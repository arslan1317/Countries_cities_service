function ContactGroupNumbers() {
    this.name = 'contact_group_numbers';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO contact_group_number (group_id, customer_id) VALUES ($1, $2) #RETURNING',
            name: 'insert-contact-groups-number',
            simple_name: 'new_contact_groups_numbers',
        },
        {
            text: 'SELECT #COLUMNS FROM contact_group_number #WHERE',
            name: 'fetch-contact-group-number',
            simple_name: 'get_contact_group_number',
        },
        {
            text: 'UPDATE contact_group_number SET #COLUMNS #WHERE',
            name: 'update-contact-group-number',
            simple_name: 'update_contact_group_number',
        },
        {
            text: 'SELECT COUNT(id) FROM contact_groups #WHERE',
            name: 'fetch-contact-groups-count',
            simple_name: 'get_count',
        },
        {
            text:'DELETE FROM contact_group_number #WHERE',
            name:'delete_contact_group_number',
            simple_name: 'remove_contact_group_number'
        }
    ];
};

module.exports = ContactGroupNumbers;