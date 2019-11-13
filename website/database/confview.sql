-- DATABASE FOR CONFVIEW WEBSITE & APPLICATION

DROP IF EXISTS conference;
DROP IF EXISTS node;
DROP IF EXISTS location;



CREATE TABLE conference (
    id              INTEGER PRIMARY KEY,
    name            VARCHAR UNIQUE NOT NULL ON CONFLICT ABORT,
    code            INTEGER UNIQUE NOT NULL ON CONFLICT ABORT
);

CREATE TABLE node (
    id              INTEGER PRIMARY KEY,
    conference_id   INTEGER REFERENCES conference(id) ON DELETE CASCADE,
    location_id     INTEGER REFERENCES location(id) ON DELETE CASCADE,
    isTag           BOOLEAN DEFAULT FALSE
);

CREATE TABLE location (
    id                   INTEGER PRIMARY KEY
    x_coord              INTEGER NOT NULL ON CONFLICT ABORT,
    y_coord              INTEGER NOT NULL ON CONFLICT ABORT
);

