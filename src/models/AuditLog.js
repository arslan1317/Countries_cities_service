function AuditLog() {

    this.name = 'audit_log';

    this.queries = {};

    this.sql = [
        {
            text: 'INSERT INTO audit_logs (event_id, event, level, dt) VALUES ($1, $2, $3, NOW())',
            name: 'insert',
            simple_name: 'save_log',
        }
    ];

};

module.exports = AuditLog;