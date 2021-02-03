function UsersSchemaParameters(opts){
    const { Joi } = opts;

    this.create = () => {
        return Joi.object().keys({
            username: Joi.string().required().trim(),
            password: Joi.string().required().trim(),
            email: Joi.string().required().trim(),
            number: Joi.string().required().trim(),
        }).unknown(true);
    };

    this.update = () => {
        return Joi.object().keys({
            username: Joi.string().required().trim(),
            password: Joi.string().required().trim(),
            email: Joi.string().required().trim(),
            number: Joi.string().required().trim(),
        }).unknown(true);
    };

    this.generateEmail = () => {
        return Joi.object().keys({
            email: Joi.string().required().trim(),
            password: Joi.string().required().trim(),
            from: Joi.string().required().trim(),
            number: Joi.string().required(),
            description: Joi.string().required().trim(),
            title: Joi.string().required().trim(),
            service: Joi.string().required().trim()
        });
    }

    this.resetPassword = () => {
        return Joi.object().keys({
            resetToken: Joi.string().required().trim(),
            password: Joi.string().required().trim(),
            cpassword: Joi.string().required().trim()
        });
    }

    this.toggle = () => {
        return Joi.object().keys({
            enabled: Joi.boolean().required()
        });
    }

};

module.exports = UsersSchemaParameters;