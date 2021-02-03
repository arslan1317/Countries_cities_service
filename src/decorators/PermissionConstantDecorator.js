function PermissionConstantDecorator(opts) {
    const { pConstants, utilities } = opts;

    const { asyncForEach } = utilities;

    const pConstantsDecorated = {};

    this.getConstants = () => pConstantsDecorated;

    this.getDecorated = async function getDecorated(initOnly = false) {
        const keys = Object.keys(pConstants);

        await asyncForEach(keys, async (pKey) => {
            if (!pConstantsDecorated[pKey]) pConstantsDecorated[pKey] = [];

            const permissions = Object.keys(pConstants[pKey]);

            await asyncForEach(permissions, (permission) => {
                pConstantsDecorated[pKey].push(permission);
            });

        });
        console.log("PCONSTANTS >", pConstantsDecorated);
        if (initOnly) {
            return;
        }

        return pConstantsDecorated;
    };
}

module.exports = PermissionConstantDecorator;