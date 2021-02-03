function ClientSettingsDecorator(opts) {

    const { utilities } = opts;

    const { asyncForEach } = utilities;

    this.decorate = async function byBotId(clientSettings) {
        const settings = {};

        await asyncForEach(clientSettings, async (setting) => {
            const { field_name, field_value, field_type, bot_id, client_id } = setting;

            const key = `client_${client_id}`;

            if (!settings[key]) settings[key] = {};

            if (!settings[key]['bot']) settings[key]['bot'] = bot_id;

            settings[key][field_name] = field_value;
        });

        return settings;
    }

};

module.exports = ClientSettingsDecorator;