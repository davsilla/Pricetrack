BEGIN;

CREATE EXTENSION pgcrypto;
CREATE EXTENSION pg_trgm;

CREATE TABLE IF NOT EXISTS stores
(
	id		UUID DEFAULT gen_random_uuid(),
	name	VARCHAR(127) NOT NULL UNIQUE,
	url		VARCHAR(1023) UNIQUE,

	CONSTRAINT stores_id_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS info
(
	id			UUID DEFAULT gen_random_uuid(),
	name		VARCHAR(511) NOT NULL UNIQUE,
	brand		VARCHAR(255),
	model		VARCHAR(127),
	image_url	VARCHAR(1023),
	interest	INT NOT NULL DEFAULT 0,

	CONSTRAINT info_id_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS categories
(
	info_id	UUID,
	name	VARCHAR(127),

	CONSTRAINT categories_pk PRIMARY KEY (info_id, name),
	CONSTRAINT categories_info_id FOREIGN KEY (info_id) REFERENCES info (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS items
(
	id				UUID DEFAULT gen_random_uuid(),
	url				VARCHAR(1023) NOT NULL UNIQUE,
	store_id		UUID,
	info_id			UUID,

	CONSTRAINT items_id_pk PRIMARY KEY (id),
	CONSTRAINT unique_item_store_info_pair UNIQUE (store_id, info_id),
	CONSTRAINT items_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE,
	CONSTRAINT items_info_id_fk FOREIGN KEY (info_id) REFERENCES info (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS price_data
(
	item_id			UUID,
	xpath			VARCHAR(511) NOT NULL,
	price			INT NOT NULL DEFAULT 0,
	price_diff		INT NOT NULL DEFAULT 0,
	last_update		TIMESTAMP,
	next_update		TIMESTAMP,
	min_price		INT,
	min_price_ts	TIMESTAMP,
	max_price		INT,
	max_price_ts	TIMESTAMP,
	update_freq		INTERVAL NOT NULL,
	status			VARCHAR(63) NOT NULL DEFAULT 'NEW',

	CONSTRAINT price_data_item_id_pk FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS logs
(
	item_id		UUID,
	price		INT,
	status		VARCHAR(63),
	updated_at	TIMESTAMP,

	CONSTRAINT logs_item_id_fk FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users
(
	id			UUID DEFAULT gen_random_uuid(),
	email		TEXT NOT NULL UNIQUE,
	password	TEXT NOT NULL UNIQUE,

	CONSTRAINT user_id_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS notify
(
	user_id			UUID,
	item_id			UUID,
	price_target	INT,
	notified		BOOLEAN,

	CONSTRAINT notify_user_id_item_id_pk PRIMARY KEY (user_id, item_id),
	CONSTRAINT notify_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION insert_item(store_id UUID, info_id UUID, url VARCHAR(1023), xpath VARCHAR(511), update_freq INTERVAL = '1 hour')
RETURNS BOOLEAN AS $$
	DECLARE
		item_res UUID;
	BEGIN
		INSERT INTO items (store_id, info_id, url) VALUES (store_id, info_id, url) RETURNING id INTO item_res;

		INSERT INTO price_data (item_id, xpath, update_freq) VALUES (item_res, xpath, update_freq);

		RETURN TRUE;
	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_item(store_id UUID, name VARCHAR(510), url VARCHAR(1023), xpath VARCHAR(511), brand VARCHAR(255) = NULL, model VARCHAR(127) = NULL, image_url VARCHAR(1023) = NULL, category_list VARCHAR(127)[] = NULL, update_freq INTERVAL = '1 hour')
RETURNS BOOLEAN AS $$
	DECLARE
		info_res UUID;
		item_res UUID;
	BEGIN
		INSERT INTO info (name, brand, model, image_url) VALUES (name, brand, model, image_url) RETURNING id INTO info_res;

		INSERT INTO items (store_id, info_id, url) VALUES (store_id, info_res, url) RETURNING id INTO item_res;

		INSERT INTO price_data (item_id, update_freq, xpath) VALUES (item_res, update_freq, xpath);

		IF (category_list IS NOT NULL) THEN
			INSERT INTO categories (info_id, name) SELECT info_res, UNNEST(category_list);
		END IF;

		RETURN TRUE;
	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION price_update()
RETURNS TRIGGER AS $price_update$
	DECLARE
		cts TIMESTAMP;
	BEGIN
		cts = NOW();

		NEW.last_update = cts;
		NEW.next_update = cts + NEW.update_freq;

		IF (OLD.status = 'NEW' AND NEW.status = 'OK') THEN
			NEW.price_diff = 0;

			NEW.min_price = NEW.price;
			NEW.min_price_ts = cts;

			NEW.max_price = NEW.price;
			NEW.max_price_ts = cts;
		
		ELSIF (NEW.status = 'OK') THEN
			NEW.price_diff = NEW.price - OLD.price;

			IF (NEW.price <= OLD.min_price) THEN
				NEW.min_price = NEW.price;
				NEW.min_price_ts = cts;
			END IF;

			IF (NEW.price >= OLD.max_price) THEN
				NEW.max_price = NEW.price;
				NEW.max_price_ts = cts;
			END IF;
		END IF;

		IF (NEW.price IS DISTINCT FROM OLD.price) THEN
			INSERT INTO logs (item_id, price, status, updated_at) VALUES (OLD.item_id, NEW.price, NEW.status, cts);
		END IF;

		RETURN NEW;
	END;
$price_update$ LANGUAGE plpgsql;

CREATE TRIGGER update_prices
BEFORE UPDATE ON price_data
FOR EACH ROW EXECUTE FUNCTION price_update();

COMMIT;
