module.exports = {
    apps: [
        {
            name: 'Global Service',
            script: 'server.js',
            cwd: __dirname,
            args: ["--tenv", "debug"],
            instances: 1,
            autorestart: true,
            watch: false,
            max_memory_restart: '1G',
        }
    ]
};
