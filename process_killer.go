package main

import (
	"bufio"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"time"

	"github.com/go-sql-driver/mysql"
)

type ProcessSummary struct {
	ProcessId  string
	User       string
	Host       string
	Db         string
	SqlHistory []string
}

func idleProcessKiller(userRegex string, idleTime uint) {
	log.Println("killProcessJob start")

	db := createDbConnection()
	defer db.Close()

	cmd := exec.Command("pt-kill",
		"--host", os.Getenv("DB_HOST"),
		"--user", os.Getenv("DB_USER"),
		"--password", os.Getenv("DB_PWD"),
		"--match-user", userRegex,
		"--match-command", "Sleep",
		"--idle-time", strconv.FormatUint(uint64(idleTime), 10),
		"--victims", "all",
		"--log-dsn", fmt.Sprintf("D=%v,t=KilledProcess", os.Getenv("DB_NAME")),
		"--interval", "5",
		"--rds",
		"--wait-before-kill", "5",
		"--print",
		"--kill",
	)
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		log.Println(err)
	}

	if err := cmd.Start(); err != nil {
		log.Println(err)
		return
	}

	pattern, _ := regexp.Compile("KILL ([0-9]+)")
	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		line := scanner.Text()
		log.Printf("Receive: %v", line)
		matches := pattern.FindStringSubmatch(line)
		if len(matches) < 2 {
			log.Printf("Cannot find process id from pt-kill log: %v", line)
			continue
		}

		processId, err := strconv.Atoi(matches[1])
		if err != nil {
			log.Printf("Cannot convert %v to int err: %v", matches[1], err)
			continue
		}

		log.Printf("Retreiving processId[%v] sql history...", processId)
		queryStr := `
			SELECT ps.id, COALESCE(ps.user, ''), COALESCE(ps.host, ''), COALESCE(ps.db, ''), COALESCE(esh.sql_text, '')
			FROM information_schema.processlist AS ps
			LEFT JOIN performance_schema.threads AS th ON th.processlist_id=ps.id
			LEFT JOIN performance_schema.events_statements_history AS esh ON esh.thread_id=th.thread_id
			WHERE ps.id=?
			ORDER BY esh.EVENT_ID
		`
		results, err := db.Query(queryStr, processId)
		if err != nil {
			log.Printf("Query %v failed err: %v", queryStr, err)
			continue
		}

		var summary ProcessSummary
		for results.Next() {
			var sqlText string
			err := results.Scan(&summary.ProcessId, &summary.User, &summary.Host, &summary.Db, &sqlText)
			if err != nil {
				log.Printf("Cannot parse process detail from db err: %v", err)
				continue
			}
			summary.SqlHistory = append(summary.SqlHistory, sqlText)
		}

		log.Println(summary)

		queryStr = `
			INSERT INTO KilledProcessHistory (processId, user, host, db, sqlHistory)
			VALUES (?, ?, ?, ?, ?)
		`

		jsonSqlHistory, err := json.Marshal(summary.SqlHistory)
		if err != nil {
			log.Printf("Fail to encode %v to JSON err: %v", summary.SqlHistory, err)
			continue
		}

		_, err = db.Query(queryStr, summary.ProcessId, summary.User, summary.Host, summary.Db, jsonSqlHistory)
		if err != nil {
			log.Printf("Query %v failed err: %v", queryStr, err)
			continue
		}
		log.Printf("History of processId[%v] saved", processId)
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}

	log.Println("killProcessJob escape")
}

func createDbConnection() *sql.DB {
	var db *sql.DB

	config := mysql.NewConfig()
	config.User = os.Getenv("DB_USER")
	config.Passwd = os.Getenv("DB_PWD")
	config.Addr = os.Getenv("DB_HOST")
	config.DBName = os.Getenv("DB_NAME")
	config.Loc = time.UTC
	config.Collation = "utf8mb4_general_ci"
	config.Net = "tcp"

	db, err := sql.Open("mysql", config.FormatDSN())
	if err != nil {
		panic(err)
	}
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(5)
	db.SetMaxIdleConns(5)
	return db
}
