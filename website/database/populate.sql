PRAGMA foreign_keys = on;


-- INSERT USERS
-- username: bernas password: bernas123
INSERT INTO user VALUES (1, 'bernas', '$2y$10$jg3dahQYJUeS3e5zLBp.7.75AZaweaGpOEnThMHiMBg1KE45AFRrK');


-- INSERT CONFERENCE
INSERT INTO conference VALUES (1, 'bernas', 'Programming 2020', 2020, '2019-12-10', '2019-12-20', 'Faculdade de Engenharia da Universidade do Porto', 'Porto', 'The best conference of them all!', 1);

-- create nodes for the conference
INSERT INTO node(conf_id, conference, x, y, name) VALUES (1,  1,   0.0,  0.0, 'Entrada');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (2,  1,  -3.0, 48.0, 'Auditório');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (3,  1,  14.0,  5.0, 'Serviços Académicos');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (4,  1,  59.0,  5.0, 'Tesouraria');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (5,  1, 107.0,  5.0, 'Saída D.Bea');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (6,  1, 107.0,  2.0, 'Casa de Banho D.Bea');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (7,  1, 154.0,  5.0, 'Corredor 1');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (8,  1, 154.0,  2.0, 'Casa de Banho Corredor 1');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (9,  1, 213.0,  5.0, 'Saída Queijos');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (10, 1, 222.0,  7.0, 'Queijos');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (11, 1, 245.0,  5.0, 'Corredor 2');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (12, 1, 245.0,  2.0, 'Casa de Banho Corredor 2');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (13, 1, 293.0,  5.0, 'Saída Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (14, 1, 293.0, 16.0, 'Coberto Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (15, 1, 308.0, 16.0, 'Bar da Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (16, 1, 205.0, 50.0, 'L');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (17, 1, 235.0, 50.0, 'DEEC');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (18, 1, 287.0, 52.0, 'DEI');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (19, 1, 322.0, 28.0, 'Entrada Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (20, 1, 301.0, 28.0, 'Escadas Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (21, 1, 291.0, 42.0, 'L Coberto Biblioteca');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (22, 1, 280.0, 51.0, 'Escadas DEI');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (23, 1, 154.0, 50.0, 'DEC');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (24, 1, 107.0, 50.0, 'Minas');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (25, 1,  59.0, 50.0, 'DEQ');
INSERT INTO node(conf_id, conference, x, y, name) VALUES (26, 1,  10.0, 72.0, 'Bar de Minas');

-- create the edges that connect those nodes
INSERT INTO edge(conference, origin, destination) VALUES (1,  1,  2);
INSERT INTO edge(conference, origin, destination) VALUES (1,  1,  3);
INSERT INTO edge(conference, origin, destination) VALUES (1,  2, 26);
INSERT INTO edge(conference, origin, destination) VALUES (1,  3,  4);
INSERT INTO edge(conference, origin, destination) VALUES (1,  4,  5);
INSERT INTO edge(conference, origin, destination) VALUES (1,  5,  6);
INSERT INTO edge(conference, origin, destination) VALUES (1,  5,  7);
INSERT INTO edge(conference, origin, destination) VALUES (1,  5, 24);
INSERT INTO edge(conference, origin, destination) VALUES (1,  7,  8);
INSERT INTO edge(conference, origin, destination) VALUES (1,  7,  9);
INSERT INTO edge(conference, origin, destination) VALUES (1,  9, 10);
INSERT INTO edge(conference, origin, destination) VALUES (1,  9, 16);
INSERT INTO edge(conference, origin, destination) VALUES (1, 10, 11);
INSERT INTO edge(conference, origin, destination) VALUES (1, 11, 12);
INSERT INTO edge(conference, origin, destination) VALUES (1, 11, 13);
INSERT INTO edge(conference, origin, destination) VALUES (1, 13, 14);
INSERT INTO edge(conference, origin, destination) VALUES (1, 14, 15);
INSERT INTO edge(conference, origin, destination) VALUES (1, 14, 20);
INSERT INTO edge(conference, origin, destination) VALUES (1, 14, 21);
INSERT INTO edge(conference, origin, destination) VALUES (1, 15, 20);
INSERT INTO edge(conference, origin, destination) VALUES (1, 16, 23);
INSERT INTO edge(conference, origin, destination) VALUES (1, 16, 17);
INSERT INTO edge(conference, origin, destination) VALUES (1, 17, 22);
INSERT INTO edge(conference, origin, destination) VALUES (1, 18, 22);
INSERT INTO edge(conference, origin, destination) VALUES (1, 18, 19);
INSERT INTO edge(conference, origin, destination) VALUES (1, 19, 20);
INSERT INTO edge(conference, origin, destination) VALUES (1, 21, 22);
INSERT INTO edge(conference, origin, destination) VALUES (1, 23, 24);
INSERT INTO edge(conference, origin, destination) VALUES (1, 24, 25);
INSERT INTO edge(conference, origin, destination) VALUES (1, 25, 26);

-- create the images
