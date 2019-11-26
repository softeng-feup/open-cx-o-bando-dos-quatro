-- DATABASE FOR CONFVIEW WEBSITE & APPLICATION

DROP TABLE IF EXISTS conference;
DROP TABLE IF EXISTS node;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS edge;


CREATE TABLE conference (
    confName            VARCHAR PRIMARY KEY,
    code                INTEGER UNIQUE NOT NULL ON CONFLICT ABORT
);

CREATE TABLE node (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    conference_name     INTEGER REFERENCES conference(confName) ON DELETE CASCADE,
    location_id         INTEGER REFERENCES location(id) ON DELETE CASCADE,
    isTag               BOOLEAN DEFAULT FALSE
);

CREATE TABLE location (
    id                   INTEGER PRIMARY KEY AUTOINCREMENT,
    x_coord              REAL NOT NULL ON CONFLICT ABORT,
    y_coord              REAL NOT NULL ON CONFLICT ABORT
);

CREATE TABLE edge(

    id                   INTEGER PRIMARY KEY AUTOINCREMENT,
    origin_node          INTEGER REFERENCES node(id) ON DELETE CASCADE,        
    dest_node            INTEGER REFERENCES node(id) ON DELETE CASCADE

);

