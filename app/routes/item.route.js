const debug = require("debug")("app:item");
const express = require("express");
const db = require("../services/db.service");
const { extractFlashMessages } = require("../utils/auth.utils");
const { requireAuthentication } = require("../middleware/auth.middleware");
const router = express.Router();

router.all("/", function (req, res, next) {
	res.redirect("/");
});

router.get("/add", requireAuthentication, async function (req, res, next) {
	const stores = await db.query("SELECT * FROM stores");
	let messages = extractFlashMessages(req);
	res.render("item/add", { stores: stores.rows, messages: messages.length > 0 ? messages : null });
});

router.post("/add", requireAuthentication, async function (req, res, next) {
	const { url, xpath, store_id, store_name, store_url, name, image, categories, brand, model, days, hours, minutes } = req.body;

	// insert one new item
	let query = "";
	const ctgs = categories.replaceAll(/, |,/g, "\',\'");
	if (!Array.isArray(store_id)) {
		if (!store_id) {
			// insert unknown store then item
			const storeUrl = store_url === "" ? "NULL" : `\'${store_url}\'`;
			query = `
			WITH store AS (
				INSERT INTO stores (name, url)
				VALUES (\'${store_name}\', ${storeUrl})
				RETURNING id
			) SELECT insert_item(
				url => \'${url}\',
				xpath => \'${xpath}\',
				store_id => store.id,
				name => \'${name}\',
				update_freq => \'${days} days ${hours} hours ${minutes} minutes\',
				category_list => ARRAY['${ctgs}'],
				image_url => \'${image}\',
				brand => \'${brand}\',
				model => \'${model}\'
			) FROM store
			`;
		} else {
			query = `
			SELECT insert_item(
				url => \'${url}\',
				xpath => \'${xpath}\',
				store_id => \'${store_id}\',
				name => \'${name}\',
				update_freq => \'${days} days ${hours} hours ${minutes} minutes\',
				category_list => ARRAY[\'${ctgs}\'],
				image_url => \'${image}\',
				brand => \'${brand}\',
				model => \'${model}\'
			)`;
		}
		try {
			await db.query(query);
			req.flash("success", `Added ${name} to database.`);
			res.redirect("/item/add");
			return;
		} catch (error) {
			req.flash("error", `Unable to add ${name} database.`);
			res.redirect("/item/add");
			return;
		}
	}

	// insert multiple items
	try {
		client = await db.getClient();
		await client.query("BEGIN");

		// insert item info
		const infoQuery = `INSERT INTO info (name, brand, model, image_url) VALUES (\'${name}\', \'${brand}\', \'${model}\', \'${image}\') RETURNING id`;
		const dbInfoRes = await client.query(infoQuery);
		const infoID = dbInfoRes.rows[0]["id"];

		// insert categories
		const ctgsQuery = `INSERT INTO categories (info_id, name) SELECT \'${infoID}\', UNNEST(ARRAY[\'${ctgs}\'])`;
		await client.query(ctgsQuery);

		// insert store and item
		store_id.forEach(async (value, index) => {
			const storeName = `\'${store_name[index]}\'`;
			const storeUrl = store_url[index] === "" ? "NULL" : `\'${store_url[index]}\'`;
			const freqNotValid = days + hours + minutes === 0
			let query = "";
			if (value === '') {
				// insert unknown store then item
				query = `
				WITH store AS (
					INSERT INTO stores (name, url)
					VALUES (${storeName}, ${storeUrl})
					RETURNING id
				) SELECT insert_item(
					store_id => store.id,
					info_id => \'${infoID}\',
					url => \'${url[index]}\',
					xpath => \'${xpath[index]}\',
					update_freq => \'${days} days ${hours} hours ${freqNotValid ? 30 : minutes} minutes\'
				) FROM store
				`;
			} else {
				query = `
				SELECT insert_item(
					store_id => \'${value}\',
					info_id => \'${infoID}\',
					url => \'${url[index]}\',
					xpath => \'${xpath[index]}\',
					update_freq => \'${days} days ${hours} hours ${freqNotValid ? 30 : minutes} minutes\'
				)
				`;
			}
			await client.query(query);
		});

		req.flash("success", `Added ${name} to database.`);
		await client.query("COMMIT");
	} catch (error) {
		if (client) await client.query("ROLLBACK");
		req.flash("error", `Unable to add ${name} database.`);
	} finally {
		if (client) client.release();
		res.redirect("/item/add");
	}
});

router.get("/data/:id", async function (req, res, next) {
	const { id } = req.params;
	const isLoggedIn = (req.user && req.isAuthenticated());
	let messages = extractFlashMessages(req);

	const query = `
	SELECT i.name, i.brand, i.model, i.image_url, i.interest, c.categories, p.info_id, p.list
	FROM info AS i
	JOIN (SELECT info_id, array_agg(name) AS categories FROM categories GROUP BY info_id) AS c
	ON i.id=c.info_id
	JOIN (SELECT t.info_id, json_agg(t) AS list 
	FROM (SELECT i.id, i.url, i.store_id, i.info_id, s.name AS store_name, p.price, p.price_diff, p.last_update, p.next_update, p.min_price, p.max_price, p.min_price_ts, p.max_price_ts, p.status, p.update_freq, h.history
	FROM stores AS s 
	JOIN items AS i ON s.id=i.store_id
	LEFT JOIN (SELECT item_id, json_agg(il) AS history
	FROM (SELECT * FROM logs) AS il
	GROUP BY item_id) AS h ON i.id=h.item_id 
	JOIN price_data AS p ON p.item_id=i.id) AS t
	GROUP BY t.info_id) AS p
	ON p.info_id=i.id
	WHERE p.info_id=\'${id}\'
	`;

	try {
		const dbRes = await db.query(query);
		debug("item: %O", dbRes.rows[0]);
		res.render("item/item", { isLoggedIn, item: dbRes.rows[0], messages });
	} catch (error) {
		next(error);
	}
});

router.post("/data/:id", requireAuthentication, async function (req, res, next) {
	const { id } = req.params;
	const { price_target } = req.body;
	const user = req.user;

	const query = `
	INSERT INTO notify(user_id, item_id, price_target, notified)
	VALUES (\'${user.id}\', \'${id}\', ${Math.floor(price_target * 100)}, false)
	`;

	try {
		await db.query(query);
		req.flash("success", `Price target to <= $${price_target}`);
		res.redirect(`/item/${id}`);
	} catch (error) {
		req.flash("error", `Failed to create price watch.`);
		res.redirect(`/item/${id}`);
	}
});

module.exports = router;
