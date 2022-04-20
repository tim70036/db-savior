package main

import (
	"os"
	"sync"
	"time"

	"github.com/joho/godotenv"
	"github.com/robfig/cron/v3"
)

func forever() {
	wg := sync.WaitGroup{}
	wg.Add(1)
	wg.Wait()
}

func main() {
	if err := godotenv.Load(); err != nil && !os.IsNotExist(err) {
		panic(err)
	}

	go idleProcessKiller("Worker|WebServer", 60)

	job := cron.New(cron.WithLocation(time.UTC))
	job.AddFunc("@every 5s", logDeadlock)
	job.AddFunc("@every 5s", logFkError)
	job.AddFunc("0 0 0 * * *", func() { archiveStaleData("Joker", "RankRecord", "JokerArchive", "RankRecord", 30) })
	job.Start()

	forever()
}
