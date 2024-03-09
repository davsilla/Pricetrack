const debug = require("debug")("app:main")
const express = require("express");
const db = require("../services/db.service");

const router = express.Router();

router.get("/", async function (req, res, next) {
	const isLoggedIn = (req.user && req.isAuthenticated());
	const query = `
		SELECT i.name, i.brand, i.model, i.image_url, i.interest, c.categories, p.info_id, p.list
		FROM info AS i
		JOIN (SELECT info_id, array_agg(name) AS categories FROM categories GROUP BY categories.info_id) AS c
		ON i.id=c.info_id
		JOIN (SELECT t.info_id, json_agg(t) AS list 
		FROM (SELECT i.id, i.store_id, i.info_id, s.name AS store_name, p.price, p.price_diff, p.last_update, p.next_update, p.min_price, p.max_price, p.min_price_ts, p.max_price_ts, p.status, p.update_freq
		FROM stores AS s 
		JOIN items AS i ON s.id=i.store_id 
		JOIN price_data AS p ON p.item_id=i.id) AS t
		GROUP BY t.info_id) AS p
		ON p.info_id=i.id
	`;

	try {
		const dbRes = (await db.query(query));
		res.render("index", { isLoggedIn, featuredItems: dbRes.rows, messages: null });
	} catch (error) {
		res.render("index", { isLoggedIn, featuredItems: null, messages: [{ error: error.message }] });
	}
});

router.get("/search", async function (req, res, next) {
	const { name } = req.query;
	const isLoggedIn = (req.user && req.isAuthenticated());
	const query = `
	SELECT i.name, i.brand, i.model, i.image_url, i.interest, c.categories, p.info_id, p.list
	FROM info AS i
	JOIN (SELECT info_id, array_agg(name) AS categories FROM categories GROUP BY categories.info_id) AS c
	ON i.id=c.info_id
	JOIN (SELECT t.info_id, json_agg(t) AS list 
	FROM (SELECT i.id, i.store_id, i.info_id, s.name AS store_name, p.price, p.price_diff, p.last_update, p.next_update, p.min_price, p.max_price, p.min_price_ts, p.max_price_ts, p.status, p.update_freq
	FROM stores AS s 
	JOIN items AS i ON s.id=i.store_id 
	JOIN price_data AS p ON p.item_id=i.id) AS t
	GROUP BY t.info_id) AS p
	ON p.info_id=i.id
	WHERE \'${name}\' % ANY(STRING_TO_ARRAY(i.name, \' \'))
	`;
	try {
		const dbRes = (await db.query(query));
		res.render("item/search", { isLoggedIn, count: dbRes.rowCount, items: dbRes.rows, name, messages: null });
	} catch (error) {
		res.render("item/search", { isLoggedIn, count: 0, items: [], name, messages: [{ error: error.message }] });
	}
});

module.exports = router;
