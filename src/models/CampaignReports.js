function CampaignReports(opts){
    this.name = 'campaign_reports';

    this.queries = {};

    this.sql = [
        {
            text: `SELECT #COLUMNS from campaign_consumers CC INNER JOIN campaigns CAM ON CC.campaign_id = CAM.id GROUP BY CAM.name,CC.campaign_id ORDER BY CC.campaign_id;`,
            name: 'fetch-campaign_stats',
            simple_name: 'get_campaign_stats',
        },
        {
            text: `select #COLUMNS from campaign_consumers CC INNER JOIN message_states MS ON CC.wt_status = MS.id #WHERE GROUP BY CC.campaign_id,MS.state_text ORDER BY CC.campaign_id;`,
            name: 'fetch-campaign_stats_pie',
            simple_name: 'get_campaign_stats_pie',
        },
        {
            text:'SELECT #COLUMNS FROM public.campaigns CAM #WHERE',
            name:'fetch-campaign',
            simple_name: 'get_campaign'
        },
        {
            text:'SELECT COUNT(CAM.id) FROM public.campaigns CAM #WHERE',
            name:'fetch-campaign',
            simple_name: 'get_count'
        }
    ];

};

module.exports = CampaignReports;