const config = {
	host: process.env.DATABASE_URL,
	port: process.env.DATABASE_PORT,
	database: process.env.DATABASE_NAME,
	user: process.env.DATABASE_USER,
	password: process.env.DATABASE_PASSWORD
};

module.exports = { config };
