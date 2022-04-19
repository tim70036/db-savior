package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
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
		"--match-user", "Worker|WebServer",
		"--match-command", "Sleep",
		"--idle-time", "60",
		"--victims", "all",
		"--log-dsn", fmt.Sprintf("D=%v,t=KilledProcess", os.Getenv("DB_SCHEMA")),
		"--iteration", "1",
		"--rds",
		"--wait-before-kill", "5",
		"--print",
		// "--kill",
	)
	out, err := cmd.CombinedOutput()
	log.Println(string(out))
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}

	log.Println("killProcessJob done")
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
	// job.AddFunc("@every 5s", deadlockLoggerJob)
	// job.AddFunc("@every 5s", fkErrorLoggerJob)
	job.AddFunc("@every 5s", killProcessJob)
	job.Start()
	forever()
}
