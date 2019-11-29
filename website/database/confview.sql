-- DATABASE FOR CONFVIEW WEBSITE & APPLICATION

DROP TABLE IF EXISTS conference;
DROP TABLE IF EXISTS node;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS edge;


CREATE TABLE conference (
    id                  INTEGER PRIMARY KEY,
    confName            VARCHAR UNIQUE NOT NULL ON CONFLICT ABORT,
    code                INTEGER UNIQUE NOT NULL ON CONFLICT ABORT
);

CREATE TABLE node (
    id                  INTEGER PRIMARY KEY,
    conference_id       INTEGER REFERENCES conference(id) ON DELETE CASCADE,
    x_coord             REAL NOT NULL ON CONFLICT ABORT,
    y_coord             REAL NOT NULL ON CONFLICT ABORT,
    isTag               BOOLEAN DEFAULT FALSE
);


CREATE TABLE edge(

    id                   INTEGER PRIMARY KEY,
    origin_node          INTEGER REFERENCES node(id) ON DELETE CASCADE,        
    dest_node            INTEGER REFERENCES node(id) ON DELETE CASCADE

);

