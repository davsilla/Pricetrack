const debug = require("debug")("app:database");
const { config } = require("../configs/db.config");
const pg = require("pg");

const pool = new pg.Pool(config);

const query = async (text, params) => {
	const start = Date.now()
	const res = await pool.query(text, params)
	const duration = Date.now() - start
	debug("executed query %O", { text, duration, rows: res.rowCount })
	return res
}

const getClient = async () => {
	const client = await pool.connect()
	const query = client.query
	const release = client.release
	// set a timeout of 5 seconds, after which we will log this client"s last query
	const timeout = setTimeout(() => {
		debug("A client has been checked out for more than 5 seconds!")
		debug(`The last executed query on this client was: ${client.lastQuery}`)
	}, 5000)
	// monkey patch the query method to keep track of the last query executed
	client.query = (...args) => {
		client.lastQuery = args
		return query.apply(client, args)
	}
	client.release = () => {
		// clear our timeout
		clearTimeout(timeout)
		// set the methods back to their old un-monkey-patched version
		client.query = query
		client.release = release
		return release.apply(client)
	}
	return client
}

module.exports = { pool, query, getClient };
