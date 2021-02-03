function CampaignConsumers() {

    this.name = 'campaign_consumers';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO campaign_consumers (msisdn, campaign_id, dt) VALUES ($1, $2, NOW()) #RETURNING',
            name: 'insert-campaign-consumer',
            simple_name: 'create_campaign_consumer'
        }
    ]

};

module.exports = CampaignConsumers;