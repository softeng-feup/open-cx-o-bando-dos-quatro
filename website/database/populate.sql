PRAGMA foreign_keys = on;

--creating a conference
INSERT INTO conference VALUES (1, 'Programming 2020', '1234');


-- creating nodes to a conference
INSERT INTO node VALUES (1, 1, 1, 0);
INSERT INTO node VALUES (2, 1, 9, 1);
INSERT INTO node VALUES (3, 1, 2, 1);
INSERT INTO node VALUES (4, 1, 8, 1);
INSERT INTO node VALUES (5, 1, 3, 0);
INSERT INTO node VALUES (6, 1, 7, 0);
INSERT INTO node VALUES (7, 1, 4, 0);
INSERT INTO node VALUES (8, 1, 5, 0);
INSERT INTO node VALUES (9, 1, 6, 0);

-- creating a location to tags
INSERT INTO location VALUES (1, 1.900,  -0.002);
INSERT INTO location VALUES (2, 2.009,  1.002);
INSERT INTO location VALUES (3, 10.001, 12.001);
INSERT INTO location VALUES (4, 8.888,  2.222);
INSERT INTO location VALUES (5, 6.669,  5.555);
INSERT INTO location VALUES (6, -5.555, 6.666);
INSERT INTO location VALUES (7, -4.302, 8.885);
INSERT INTO location VALUES (8, 1.111,  0.001);
INSERT INTO location VALUES (9, 4.000,  1.237);