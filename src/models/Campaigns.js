function Campaigns() {
    this.name = 'campaigns';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM campaigns #WHERE',
            name: 'get-campaigns',
            simple_name: 'get_list'
        },
        {
            text: 'INSERT INTO campaigns(name, description, template_id, message, message_params, begin_dt, consumers, client_id, created_by, activated, dt) VALUES( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW()) #RETURNING',
            name: 'create-campaigns',
            simple_name: 'create_campaign'
        },
        {
            text: 'UPDATE campaigns SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update-campaigns',
            simple_name: 'update_campaigns'
        },
        {
            text: 'SELECT COUNT(id) FROM campaigns #WHERE',
            name: 'campaign-total-count',
            simple_name: 'get_count',
        }
    ];
}

module.exports = Campaigns;