CREATE TABLE departments (
	department_id INT,
	department VARCHAR NOT NULL,
	PRIMARY KEY (department_id)
);
SELECT * FROM departments;
CREATE TABLE aisles (
	aisle_id INT, 
	aisle VARCHAR NOT NULL,
	PRIMARY KEY (aisle_id)
);
SELECT * FROM aisles;
CREATE TABLE sample_submission (
	order_id INT,
	products VARCHAR NOT NULL,
	PRIMARY KEY (order_id)
);

CREATE TABLE order_products_train (
	id SERIAL,
	order_id INT,
	product_id INT, 
	add_to_cart INT,
	reordered INT,
	PRIMARY KEY (id)
);

CREATE TABLE order_products_prior (
	id SERIAL,
	order_id INT,
	product_id INT, 
	add_to_cart_order INT,
	reordered INT,
	PRIMARY KEY (id)
);

CREATE TABLE products (
	product_id INT,
	product_name VARCHAR NOT NULL,
	aisle_id INT,
	department_id INT,
	departments_department_id INT,
	aisles_aisle_id INT,
	order_prior_id INT,
	order_train_id INT,
	PRIMARY KEY (product_id),
	FOREIGN KEY (order_prior_id) REFERENCES order_products_prior(id),
	FOREIGN KEY (departments_department_id) REFERENCES departments(department_id),
	FOREIGN KEY (aisles_aisle_id) REFERENCES aisles(aisle_id),
	FOREIGN KEY (order_train_id) REFERENCES order_products_train(id)
);

CREATE TABLE orders_clean (
	order_id INT,
	user_id NUMERIC,
	eval_set VARCHAR,
	order_number NUMERIC,
	order_dow NUMERIC,
	order_hour_of_day NUMERIC,
	days_since_prior_order NUMERIC,
	order_prior_id INT,
	order_train_id INT,
	sample_order_id INT,
	PRIMARY KEY (order_id),
	FOREIGN KEY (order_prior_id) REFERENCES order_products_prior(id),
	FOREIGN KEY (order_train_id) REFERENCES order_products_train(id),
	FOREIGN KEY (sample_order_id) REFERENCES sample_submission(order_id)
);

SELECT * FROM aisles;
SELECT * FROM products;

SELECT orders_clean.order_id, orders_clean.user_id, order_products_prior.id
FROM order_products_prior
JOIN orders_clean
ON orders_clean.order_id = order_products_prior.order_id;

SELECT orders_clean.user_id, orders_clean.order_id, order_products_prior.product_id, products.product_name
FROM orders_clean
JOIN order_products_prior
ON orders_clean.order_id = order_products_prior.order_id
JOIN products
ON order_products_prior.product_id = products.product_id
ORDER BY orders_clean.user_id;


CREATE TABLE MLcategories AS
SELECT *
FROM 
	

