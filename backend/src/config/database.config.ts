export default () => ({
    database: {
        host: process.env.DATABASE_HOST || 'localhost',
        port: parseInt(process.env.DATABASE_PORT || '3306', 10),
        user: process.env.DATABASE_USER || 'root',
        password: process.env.DATABSE_PASSWORD || '',
        name: process.env.DATABSE_NAME || 'jim-app',
    }
});
