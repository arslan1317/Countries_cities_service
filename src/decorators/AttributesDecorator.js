function AttributesDecorator(opts) {

    const { utilities } = opts;
    const { asyncForEach } = utilities;

    this.customerAttributes = async function customerAttributes(customers) {
        await asyncForEach(customers, async (customer) => {
            
        });
    };

};

module.exports = AttributesDecorator;