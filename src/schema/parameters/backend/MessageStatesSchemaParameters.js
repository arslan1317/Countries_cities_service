function MessageStatesSchemaParameters(opts){
    const { Joi } = opts;

    this.create = () => {
        return Joi.object().keys({
            state_text: Joi.string().required().trim(),
            default_state: Joi.string().required().trim()
        }).unknown(true);
    };

    this.update = () => {
        return Joi.object().keys({
            state_text: Joi.string().required().trim(),
            default_state: Joi.string().required().trim()
        }).unknown(true);
    };

};

module.exports = MessageStatesSchemaParameters;