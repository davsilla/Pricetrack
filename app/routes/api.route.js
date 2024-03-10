const debug = require("debug")("app:api")
const express = require("express");
const db = require("../services/db.service");

const router = express.Router();

router.get("/items", async function (req, res, next) {
	const { n, offset, scrapable } = req.query;
	const query = `
	SELECT i.url, (p).* 
	FROM items i
	JOIN price_data p
	ON i.id=p.item_id
	${scrapable ? "WHERE (now() >= p.next_update AND p.status='OK') OR p.status='NEW' OR p.status='FIXED'" : ""}
	LIMIT ${n ? n : "ALL"}
	OFFSET ${offset ? offset : "0"}
	`;

	try {
		const dbRes = await db.query(query);
		res.send({ success: true, items: dbRes.rows });
	} catch (error) {
		res.send({ success: false, items: [], message: error.message });
	}
});

router.put("/update/price/:id", async function (req, res, next) {
	const { id } = req.params;
	const { price, status } = req.body;

	const query = `UPDATE price_data SET price=${price}, status='${status}' WHERE id='${id}'`;

	try {
		const dbRes = await db.query(query);
		res.send({ success: true, items: dbRes.rows });
	} catch (error) {
		res.send({ success: false, items: [], message: error.message });
	}
});

router.put("/update/prices", async function (req, res, next) {
	const data = req.body;
	const values = data.map(i => `('${i.item_id}','${i.status}', ${i.price})`).join(",");

	const query = `
	UPDATE price_data AS pd
	SET status=v.status, price=v.price
	FROM ( VALUES ${values} ) AS v(item_id, status, price)
	WHERE pd.item_id=v.item_id::UUID
	`;

	try {
		const dbRes = await db.query(query);
		res.send({ success: true, items: dbRes.rows });
	} catch (error) {
		res.send({ success: false, items: [], message: error.message });
	}
});

module.exports = router;
