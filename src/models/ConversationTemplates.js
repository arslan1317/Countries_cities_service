function ConversationTemplates() {
    this.name = 'conversation_templates';
    
    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO conversation_templates (template_params, template_name, template_text, template_tag, template_type, attachment_url, client_id, creator, dt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW()) #RETURNING',
            name: 'insert-conversation-template',
            simple_name: 'new_conversation_template',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_templates #WHERE',
            name: 'fetch-conversation-template',
            simple_name: 'get_conversation_template',
        },
        {
            text: 'UPDATE conversation_templates SET #COLUMNS  #WHERE',
            name: 'update-conversation-template',
            simple_name: 'update_conversation_template',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_templates #WHERE',
            name: 'fetch-conversation-template',
            simple_name: 'get_list',
        },
        {
            text: 'SELECT COUNT(id) FROM conversation_templates #WHERE',
            name: 'fetch-conversation-template-count',
            simple_name: 'get_count',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_templates #WHERE',
            name: 'select-conversation-templates-detail',
            simple_name: 'get_detail'
        },
        {
            text: 'UPDATE conversation_templates SET #COLUMNS #WHERE',
            name: 'update-conversation_templates-detail',
            simple_name: 'update_detail',
        },
        {
            text: 'SELECT #COLUMNS FROM conversation_templates #WHERE',
            name: 'select-conversation-templates-report',
            simple_name: 'get_report'
        }
    ];
};

module.exports = ConversationTemplates;