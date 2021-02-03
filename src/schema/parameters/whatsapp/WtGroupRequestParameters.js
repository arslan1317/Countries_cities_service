function WtGroupRequestParameters(opts) {

    const { Joi } = opts;

    this.update = () => {
        return {
            body: Joi.object().keys({
                type: Joi.string().valid('kick', 'subject', 'icon', 'leave', 'remove', 'add', 'kick', 'disable').trim().required(),
                subject: Joi.when('type', {
                    is: 'subject',
                    then: Joi.string().required().trim(),
                    otherwise: Joi.forbidden()
                }),
                icon: Joi.when('type', {
                    is: 'icon',
                    then: Joi.string().uri().required(),
                    otherwise: Joi.forbidden()
                }),
                leave: Joi.when('type', {
                    is: 'leave',
                    then: Joi.string().required(),
                    otherwise: Joi.forbidden()
                }),
                kick: Joi.when('type', {
                    is: 'kick',
                    then: Joi.array().items(Joi.object().keys({
                        number: Joi.string().required(),
                    })),
                    otherwise: Joi.forbidden()
                }),
                remove: Joi.when('type', {
                    is: 'remove',
                    then: Joi.array().items(Joi.object().keys({
                        number: Joi.string().required(),
                    })),
                    otherwise: Joi.forbidden()
                }),
                add: Joi.when('type', {
                    is: 'add',
                    then: Joi.array().items(Joi.object().keys({
                        number: Joi.string().required(),
                    })),
                    otherwise: Joi.forbidden()
                }),
                disable: Joi.when('type', {
                    is: 'disable',
                    then: Joi.string().uri().required(),
                    otherwise: Joi.forbidden()
                }),
            })
        }
    };

};

module.exports = WtGroupRequestParameters;