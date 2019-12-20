rm -f database/database.db

sqlite3 -init database/confview.sql database/confview.db ".read database/populate.sql"
