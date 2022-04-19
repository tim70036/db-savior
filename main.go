package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"sync"

	"github.com/joho/godotenv"
	"github.com/robfig/cron/v3"
)

func forever() {
	wg := sync.WaitGroup{}
	wg.Add(1)
	wg.Wait()
}

func killProcessJob() {
	log.Println("killProcessJob start")

	cmd := exec.Command("pt-kill",
		"--host", os.Getenv("DB_HOST"),
		"--user", os.Getenv("DB_USER"),
		"--password", os.Getenv("DB_PWD"),
		"--match-user", ".*",
		"--match-command", "Sleep",
		"--idle-time", "10",
		"--victims", "all",
		"--log-dsn", fmt.Sprintf("D=%v,t=KilledProcess", os.Getenv("DB_SCHEMA")),
		"--interval", "5",
		"--rds",
		"--wait-before-kill", "5",
		"--print",
		// "--kill",
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

		log.Printf("Parsed: %v", processId)
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}

	log.Println("killProcessJob escape")
}

func deadlockLoggerJob() {
	log.Println("deadlockLoggerJob start")

	cmd := exec.Command("pt-deadlock-logger",
		"--host", os.Getenv("DB_HOST"),
		"--user", os.Getenv("DB_USER"),
		"--password", os.Getenv("DB_PWD"),
		"--dest", fmt.Sprintf("D=%v,t=Deadlock", os.Getenv("DB_SCHEMA")),
		"--iteration", "1",
	)

	out, err := cmd.CombinedOutput()
	log.Println(string(out))
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("deadlockLoggerJob done")
}

func fkErrorLoggerJob() {
	log.Println("fkErrorLoggerJob start")

	cmd := exec.Command("pt-fk-error-logger",
		fmt.Sprintf("h=%v,u=%v,p=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD")),
		"--dest", fmt.Sprintf("D=%v,t=ForeignKeyError", os.Getenv("DB_SCHEMA")),
		"--iteration", "1",
	)

	out, err := cmd.CombinedOutput()
	log.Println(string(out))
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("fkErrorLoggerJob done")
}

func main() {
	if err := godotenv.Load(); err != nil && !os.IsNotExist(err) {
		log.Fatalln("Error loading .env")
	}

	job := cron.New()
	job.AddFunc("@every 5s", deadlockLoggerJob)
	// job.AddFunc("@every 5s", fkErrorLoggerJob)
	job.Start()

	go killProcessJob()
	forever()
}
