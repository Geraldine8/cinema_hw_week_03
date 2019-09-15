DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  show_time VARCHAR(255),
  film_id INT4,
  available_tickets INT4
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);
