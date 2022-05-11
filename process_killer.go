package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"time"
)

type ProcessSummary struct {
	ProcessId  string
	User       string
	Host       string
	Db         string
	SqlHistory []string
}

// idleProcessKiller utilizes pt-kill.
// It's a non ending function that tries to find connection that is established by matched users.
// You should run it as goroutine.
// Matched users are determined by userRegex.
// If pt-kill find these connections are in Sleep state for over idleTime seconds, the connection will be killed.
// Before killing a connection, its history will be saved into database for futher investigation.
func idleProcessKiller(userRegex string, idleTime uint) {
	for {
		log.Println("killProcessJob start")
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
			"--noversion-check",
		)

		cmd.Stderr = os.Stderr

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
			summary, err := retreiveSummary(processId)
			if err != nil {
				log.Printf("Cannot retreive summary of processId[%v] err: %v", processId, err)
				continue
			}
			log.Println(summary)

			err = saveSummary(summary)
			if err != nil {
				log.Printf("Cannot save summary of processId[%v] err: %v", processId, err)
				continue
			}
			log.Printf("History of processId[%v] saved", processId)
		}
		if err := scanner.Err(); err != nil {
			fmt.Fprintln(os.Stderr, "Scanne error:", err)
		}

		const sleepSeconds = 5
		log.Printf("killProcessJob escape restart in %v seconds...", sleepSeconds)
		time.Sleep(sleepSeconds * time.Second)
	}
}

func retreiveSummary(processId int) (*ProcessSummary, error) {
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
		return nil, err
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
	return &summary, nil
}

func saveSummary(summary *ProcessSummary) error {
	queryStr := `
		INSERT INTO KilledProcessHistory (processId, user, host, db, sqlHistory)
		VALUES (?, ?, ?, ?, ?)
	`

	jsonSqlHistory, err := json.Marshal(summary.SqlHistory)
	if err != nil {
		log.Printf("Fail to encode %v to JSON err: %v", summary.SqlHistory, err)
		return err
	}

	_, err = db.Query(queryStr, summary.ProcessId, summary.User, summary.Host, summary.Db, jsonSqlHistory)
	if err != nil {
		log.Printf("Query %v failed err: %v", queryStr, err)
		return err
	}
	return nil
}
