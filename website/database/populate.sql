PRAGMA foreign_keys = on;

--creating a conference
INSERT INTO conference(confName, code) VALUES ('Programming 2020', '1234');


-- creating nodes to a conference
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (1, 'Programming 2020', 1, 0);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (2, 'Programming 2020', 9, 1);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (3, 'Programming 2020', 2, 1);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (4, 'Programming 2020', 8, 1);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (5, 'Programming 2020', 3, 0);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (6, 'Programming 2020', 7, 0);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (7, 'Programming 2020', 4, 0);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (8, 'Programming 2020', 5, 0);
INSERT INTO node(id, conference_name, location_id, isTag) VALUES (9, 'Programming 2020', 6, 0);

-- creating a location to tags
INSERT INTO location(id, x_coord, y_coord) VALUES (1, 1.900,  -0.002);
INSERT INTO location(id, x_coord, y_coord) VALUES (2, 2.009,  1.002);
INSERT INTO location(id, x_coord, y_coord) VALUES (3, 10.001, 12.001);
INSERT INTO location(id, x_coord, y_coord) VALUES (4, 8.888,  2.222);
INSERT INTO location(id, x_coord, y_coord) VALUES (5, 6.669,  5.555);
INSERT INTO location(id, x_coord, y_coord) VALUES (6, -5.555, 6.666);
INSERT INTO location(id, x_coord, y_coord) VALUES (7, -4.302, 8.885);
INSERT INTO location(id, x_coord, y_coord) VALUES (8, 1.111,  0.001);
INSERT INTO location(id, x_coord, y_coord) VALUES (9, 4.000,  1.237);