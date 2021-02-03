function RolesSchemaParameters(opts){
    const { Joi } = opts;

    this.create = () => {
        return Joi.object().keys({
            name: Joi.string().required().trim(),
            description: Joi.string().required().trim(),
            enabled: Joi.boolean().required()
        }).unknown(true);
    };

    this.update = () => {
        return Joi.object().keys({
            name: Joi.string().required().trim(),
            description: Joi.string().required().trim(),
            enabled: Joi.boolean().required()
        }).unknown(true);
    };

};

module.exports = RolesSchemaParameters;