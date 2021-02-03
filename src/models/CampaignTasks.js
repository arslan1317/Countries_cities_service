function CampaignTasks() {

    this.name = 'campaign_tasks';

    this.queries = {};

    this.sql = [
        {
            text: 'SELECT #COLUMNS FROM campaigns #WHERE',
            name: 'fetch-campaigns',
            simple_name: 'fetch_campaigns'
        },
        {
            text: 'SELECT #COLUMNS FROM campaign_consumers #WHERE',
            name: 'fetch-consumers',
            simple_name: 'fetch_consumers'
        },
        {
            text: 'UPDATE campaigns SET #COLUMNS, dtu = NOW() #WHERE',
            name:'update-campaigns',
            simple_name: 'update_campaigns',
        },
        {
            text: 'UPDATE campaign_consumers SET #COLUMNS, dtu = NOW() #WHERE',
            name: 'update-consumers',
            simple_name: 'update_consumer'
        }
    ]

};

module.exports = CampaignTasks;