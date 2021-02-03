function UserAttributesSchemaParameters(opts){
    const { Joi } = opts;

    this.create = () => {
        return Joi.object().keys({
            attribute_name: Joi.string().required().trim(),
            attribute_value: Joi.required(),
            attribute_type: Joi.string().required().trim()
        }).unknown(true);
    };

    this.update = () => {
        return Joi.object().keys({
            attribute_name: Joi.string().required().trim(),
            attribute_value: Joi.required(),
            attribute_type: Joi.string().required().trim()
        }).unknown(true);
    };

};

module.exports = UserAttributesSchemaParameters;