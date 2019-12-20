-- DATABASE FOR CONFVIEW WEBSITE & APPLICATION

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS conference;
DROP TABLE IF EXISTS node;
DROP TABLE IF EXISTS edge;
DROP TABLE IF EXISTS image;


CREATE TABLE user (
    id                  INTEGER PRIMARY KEY,
    username            VARCHAR NOT NULL UNIQUE,
    password            VARCHAR NOT NULL ON CONFLICT ABORT
);

CREATE TABLE conference (
    id                  INTEGER PRIMARY KEY,
    username            VARCHAR NOT NULL REFERENCES user(username), 
    name                VARCHAR NOT NULL ON CONFLICT ABORT,
    code                INTEGER UNIQUE NOT NULL ON CONFLICT ABORT,
    start_date          DATE NOT NULL ON CONFLICT ABORT,
    end_date            DATE NOT NULL ON CONFLICT ABORT,
    address             VARCHAR NOT NULL ON CONFLICT ABORT,
    city                VARCHAR NOT NULL ON CONFLICT ABORT,
    description         VARCHAR NOT NULL ON CONFLICT ABORT,
    version             INTEGER NOT NULL     
);

CREATE TABLE node (
    id                  INTEGER PRIMARY KEY,
    conf_id             INTEGER NOT NULL,   -- node id
    conference          INTEGER REFERENCES conference(id) ON DELETE CASCADE,
    x                   REAL NOT NULL ON CONFLICT ABORT,
    y                   REAL NOT NULL ON CONFLICT ABORT,
    name                VARCHAR NOT NULL ON CONFLICT ABORT,

    UNIQUE (conf_id, conference)
);

CREATE TABLE edge (
    id                   INTEGER PRIMARY KEY,
    conference           INTEGER REFERENCES conference(id) ON DELETE CASCADE,
    origin               INTEGER NOT NULL,    
    destination          INTEGER NOT NULL,

    FOREIGN KEY (origin, conference) REFERENCES node(conf_id, conference),
    FOREIGN KEY (destination, conference) REFERENCES node(conf_id, conference)
);

CREATE TABLE image (
    id                  INTEGER PRIMARY KEY,
    node_id             INTEGER NOT NULL,
    conference          INTEGER NOT NULL,
    path                VARCHAR NOT NULL UNIQUE,

    FOREIGN KEY (node_id, conference) REFERENCES node(conf_id, conference)
);
