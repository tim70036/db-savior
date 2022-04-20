package main

import (
	"os"
	"sync"

	"github.com/joho/godotenv"
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

	go archiveJob()

	// job := cron.New()
	// job.AddFunc("@every 5s", deadlockLoggerJob)
	// job.AddFunc("@every 5s", fkErrorLoggerJob)
	// job.Start()

	// go killProcessJob()
	forever()
}
