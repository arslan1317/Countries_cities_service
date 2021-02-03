function ChatMessages() {
    this.name = 'chat_messages';

    this.queries = {};

    this.sql = [
        {
            name: 'fetch-conversations',
            simple_name: 'fetch_messages',
            text: `SELECT USR.username AS sender_name, OBM.id, OBM.dt, OBM.message_type, OBM.attachment_id, OBM.message_body, OBM.message_status, OBM.sender_id AS user, OBM.client_id, OBM.receiver_id AS customer_id,CAST('outbound' AS VARCHAR(8)) AS direction FROM outbound_messages AS OBM LEFT JOIN users AS USR ON USR.id = OBM.sender_id WHERE OBM.client_id = $1 AND OBM.receiver_id = $2 AND group_id = 0 UNION ALL SELECT CAST('inbound' AS VARCHAR(8)) AS sender_name, id, received_at, type, attachment_id, message_body,CAST(NULL AS BIGINT), user_id, client_id, customer_id,CAST('inbound' AS VARCHAR(8)) AS direction FROM inbound_messages WHERE client_id = $3 AND customer_id = $4 AND group_id = 0 ORDER BY dt ASC`,
        },
        {
            name: 'fetch-group-conversations',
            simple_name: 'fetch_group_messages',
            text: `SELECT id, group_id, dt, message_type, attachment_id, message_body, message_status, sender_id AS user, client_id, receiver_id AS customer_id,CAST('outbound' AS VARCHAR(8)) AS direction FROM outbound_messages WHERE client_id = $1 AND sender_id = $2 AND group_id = $3 UNION ALL SELECT id, group_id, received_at, type, attachment_id, message_body,CAST(NULL AS BIGINT), user_id, client_id, customer_id,CAST('inbound' AS VARCHAR(8)) AS direction FROM inbound_messages WHERE client_id = $4 AND user_id = $5 AND group_id = $6 ORDER BY dt ASC`,
        }
    ];
}

module.exports = ChatMessages;