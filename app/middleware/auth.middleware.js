function isAlreadyLoggedIn(req, res, next) {
	if (req.user && req.isAuthenticated()) {
		res.redirect("/");
	} else {
		next();
	}
}

function requireAuthentication(req, res, next) {
	if (req.user && req.isAuthenticated()) {
		next();
	} else {
		res.redirect("/");
	}
}

module.exports = { isAlreadyLoggedIn, requireAuthentication };
