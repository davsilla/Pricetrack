require("dotenv").config();
const express = require("express");
const cookieParser = require("cookie-parser");
const compression = require("compression");
const logger = require("morgan");

// database
const db = require("./services/db.service");

// auth packages
const LocalStrategy = require("passport-local").Strategy;
const session = require("express-session");
const pgSession = require("connect-pg-simple")(session);
const flash = require("connect-flash");
const passport = require("passport");

const path = require("path");
const createError = require("http-errors");
const debug = require("debug")("app:server");

const mainRouter = require("./routes/main.route");
const authRouter = require("./routes/auth.route");
const itemRouter = require("./routes/item.route");
const apiRouter = require("./routes/api.route");

const app = express();
const port = process.env.PORT || 3300;
const isInProduction = process.env.NODE_ENV === "production"

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use(compression());
app.use(express.static(path.join(__dirname, "public")));

// auth middleware
app.use(flash());
app.use(session({
	store: new pgSession({
		pool: db.pool,
		createTableIfMissing: true
	}),
	name: "pricetrack",
	secret: process.env.COOKIE_SECRET || "local-library-session-secret",
	saveUninitialized: false,
	resave: false,
	cookie: { maxAge: 15 * 24 * 60 * 60 * 1000, secure: isInProduction, sameSite: "lax" } // 15 days
}));

// passport setup
app.use(passport.initialize());
app.use(passport.session());

passport.use(new LocalStrategy({ usernameField: "email", passwordField: "password"}, async function (username, password, done) {
	try {
		const user = await db.query(`SELECT * FROM users WHERE email=\'${username}\' AND password=crypt(\'${password}\', password)`);

		if (user.rowCount <= 0) {
			return done(null, false);
		}

		return done(null, user.rows[0]);
	} catch (err) {
		return done(err);
	}
}));

passport.serializeUser(function (user, done) {
	done(null, user.id);
});

passport.deserializeUser(async function (id, done) {
	try {
		const user = await db.query(`SELECT * FROM users WHERE id=\'${id}\'`); 
		if (user.rowCount <= 0) {
			done(null, false);
		} else {
			done(null, user.rows[0]);
		}
	} catch (err) {
		done(err);	
	}
});

// app routes
app.use("/", mainRouter);
app.use("/auth", authRouter);
app.use("/item", itemRouter);
app.use("/api", apiRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
	next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
	// set locals, only providing error in development
	res.locals.message = err.message;
	res.locals.error = req.app.get("env") === "development" ? err : {};

	debug("%s", err.stack);

	// render the error page
	res.status(err.status || 500);
	res.render("error", { error: err });
});

app.listen(port, () => {
	debug("Server running on http://localhost:%d", port);
});
