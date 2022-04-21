package main

import (
	"database/sql"
	"log"
	"os"
	"time"

	"github.com/go-sql-driver/mysql"
)

var db *sql.DB

// initDatabase opens a connection pool to database with the preset configuration.
// There will be a package level variable db that represent the connection pool for other function to use.
func initDatabase() {
	config := mysql.NewConfig()
	config.User = os.Getenv("DB_USER")
	config.Passwd = os.Getenv("DB_PWD")
	config.Addr = os.Getenv("DB_HOST")
	config.DBName = os.Getenv("DB_NAME")
	config.Loc = time.UTC
	config.Collation = "utf8mb4_general_ci"
	config.Net = "tcp"

	var err error
	db, err = sql.Open("mysql", config.FormatDSN())
	if err != nil {
		panic(err)
	}

	log.Printf("Connected to db host[%v] user[%v] dbName[%v]", config.Addr, config.User, config.DBName)

	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(5)
	db.SetMaxIdleConns(5)
}
