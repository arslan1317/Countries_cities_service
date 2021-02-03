function CitiesSchemaParameters(opts){
    const { Joi } = opts;

    this.create = () => {
        return Joi.object().keys({
            name: Joi.string().required().trim(),
            code: Joi.string().required().trim(),
            country: Joi.number().required(),
            enabled: Joi.boolean().required()
        }).unknown(true);
    };

    this.update = () => {
        return Joi.object().keys({
            name: Joi.string().required().trim(),
            country: Joi.number().required(),
            enabled: Joi.boolean().required()
        }).unknown(true);
    };

};
module.exports = CitiesSchemaParameters;