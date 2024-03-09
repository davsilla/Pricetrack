const debug = require("debug")("app:auth");
const db = require("../services/db.service");
const express = require("express");
const passport = require("passport");
const { extractFlashMessages } = require("../utils/auth.utils");
const { isAlreadyLoggedIn, requireAuthentication } = require("../middleware/auth.middleware");
const router = express.Router();

router.all("/", function (req, res, next) {
	res.redirect("/");
});

// login route handlers
router.get("/login", isAlreadyLoggedIn, function (req, res, next) {
	let messages = extractFlashMessages(req);
	res.render("auth/login", { title: "Login", messages: messages.length > 0 ? messages : null });
});

router.post("/login", passport.authenticate("local", { successRedirect: "/", failureRedirect: "/auth/login", failureFlash: "Invalid username or password." }));

// signup route handlers
router.get("/signup", isAlreadyLoggedIn, function (req, res, next) {
	let messages = extractFlashMessages(req);
	res.render("auth/signup", { title: "Login", messages: messages.length > 0 ? messages : null });
});

router.post("/signup", isAlreadyLoggedIn, async function (req, res, next) {
	try {
		const { email, password } = req.body;
		const query = `INSERT INTO users (email, password) VALUES (\'${email}\', crypt(\'${password}\', gen_salt('bf'))) RETURNING id`;

		const dbRes = await db.query(query);
		const user = dbRes.rows[0];

		req.logIn(user, (err) => {
			if (err) {
				req.flash("error", "Unable to log in user.");
				res.redirect("/auth/signup");
				return;
			}
			res.redirect("/");
		});
	} catch (error) {
		req.flash("error", `Unable to add user database. ${error.detail}`);
		res.redirect("/auth/signup");
		return;
	}
});

// log the user out
router.post("/logout", requireAuthentication, function (req, res, next) {
	req.logout(function (err) {
		if (err) { return next(err); }
		req.session.destroy(function (err) {
			if (err) { return next(err); }
			res.redirect("/auth/login");
		})
	});
});

module.exports = router;
