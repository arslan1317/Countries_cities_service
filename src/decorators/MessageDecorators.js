function MessageDecorators(opts) {

    const { messageAttributesService, utilities } = opts;

    const { asyncForEach } = utilities;

    this.decorateV2 = async function decorateV2(conversation) {

        let messages = await conversation.map((convo, i) => {
            const { id, 
                dt, 
                message_type, 
                attachment_id, 
                message_body, 
                message_status, 
                user, 
                client_id, 
                customer_id, 
                direction,
                receiver,
                group_id,
                sender_name,
            } = convo;

            if (direction === 'outbound') {
                return {
                    sender_name,
                    outbound_id: id,
                    type: 'outbound',
                    number: receiver,
                    receiver_id: customer_id,
                    user,
                    client: client_id,
                    message_body,
                    status: message_status,
                    message_type,
                    dt,
                    attachment_id,
                    groupId: (group_id) ? group_id : 0
                };
            } else {
                return {
                    sender_name,
                    inbound_id: id,
                    type: 'inbound',
                    number: receiver,
                    receiver_id: customer_id,
                    user,
                    client: client_id,
                    message_body,
                    status: 'received',
                    message_type,
                    dt, 
                    attachment_id,
                    groupId: (group_id) ? group_id : 0
                }
            }

        });

        await asyncForEach(messages, async (message) => {
            let attachments = null;

            if (message.attachment_id && parseInt(message.attachment_id) > 0) attachments = await messageAttributesService.get(message.attachment_id, 'attribute_value, attribute_name, attribute_type', message.type);

            delete message.attachment_id;

            message['attachments'] = attachments;
        });

        return messages;
    };

    this.decorate = async function decorate({ outbound, inbound }) {
        let _outbound = await outbound.map((message) => {
            const { 
                id, 
                sender_id, 
                client_id, 
                message_body, 
                message_status, 
                message_type, 
                receiver, 
                receiver_id,
                dt, 
                attachment_id,
            } = message;

            return {
                outbound_id: id,
                type: 'outbound',
                number: receiver,
                receiver_id,
                user: sender_id,
                client: client_id,
                message_body,
                status: message_status,
                message_type,
                dt,
                attachment_id
            };
        });

        let _inbound = await inbound.map((message) => {
            const { 
                id, 
                message_id, 
                number, 
                type, 
                message_body, 
                user_id, 
                client_id, 
                customer_id, 
                received_at,
                attachment_id, 
            } = message;

            return {
                inbound_id: id,
                type: 'inbound',
                number,
                wt_id: message_id,
                receiver_id: customer_id,
                user: user_id,
                client: client_id,
                message_body,
                status: 'received',
                message_type: type,
                dt: received_at,
                attachment_id,
            }
        });

        let messages = _inbound.concat(_outbound);

        messages = messages.sort((a, b) => {
            const dateA = new Date(a.dt);
            const dateB = new Date(b.dt);

            return (dateA > dateB); 
        });

        await asyncForEach(messages, async (message) => {
            let attachments = null;

            if (message.attachment_id && parseInt(message.attachment_id) > 0) attachments = await messageAttributesService.get(message.attachment_id, 'attribute_value, attribute_name, attribute_type', message.type);

            delete message.attachment_id;

            message['attachments'] = attachments;
        });

        return messages;
    };

};

module.exports = MessageDecorators;