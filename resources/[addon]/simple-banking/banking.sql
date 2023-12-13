CREATE TABLE IF NOT EXISTS society (
	id INT(11) NOT NULL,
	name VARCHAR(255) DEFAULT NULL,
	money LONGTEXT DEFAULT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS transactions (
	id int(11) NOT NULL AUTO_INCREMENT,
	identifier varchar(50) NOT NULL,
	trans_id int(11) NOT NULL,
	account text NOT NULL,
	amount int(11) NOT NULL,
	trans_type text NOT NULL,
	receiver varchar(50) DEFAULT NULL,
	comment text NOT NULL,
	date timestamp NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`)
);
INSERT INTO `society` (`id`, `name`, `money`) VALUES
	(1, 'police', '0'),
	(2, 'lostmc', '0');
