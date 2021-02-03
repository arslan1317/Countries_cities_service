function PermissionsSchemaParameters(opts){
    const { Joi } = opts;
    
    this.update = () => {
        return Joi.object().keys({
            method: Joi.string().required().trim(),
            description: Joi.string().required().trim(),
            rule_set: Joi.required(),
            consumer: Joi.string().required().trim(),
            title: Joi.string().required().trim()
        }).unknown(true);
    };

    this.create = () => {
        return Joi.object().keys({
            description: Joi.string().required().trim(),
            rule_set: Joi.required(),
            consumer: Joi.number().required(),
            title: Joi.string().required().trim(),
            enabled: Joi.boolean().required(),
            displayed: Joi.boolean().required()
        }).unknown(true);
    };

};

module.exports = PermissionsSchemaParameters;