package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

func archiveJob() {
	log.Println("archiveJob start")

	// TODO: func args
	sourceDb, sourceTable := "Joker", "RankRecord"
	destDb, destTable := "JokerArchive", "RankRecord"

	// TODO: const
	now := time.Now().UTC().Format(time.RFC3339)
	daysBefore := "30" // func args?
	condition := fmt.Sprintf("create_time < DATE('%v') - INTERVAL %v DAY", now, daysBefore)
	batchSize := "1000"

	log.Printf("sourceDb[%v] sourceTable[%v]", sourceDb, sourceTable)
	log.Printf("destDb[%v] destTable[%v]", destDb, destTable)
	log.Printf("condition[%v]", condition)
	log.Printf("batchSize[%v]", batchSize)

	cmd := exec.Command("pt-archiver",
		"--source", fmt.Sprintf("h=%v,u=%v,p=%v,A=utf8mb4,D=%v,t=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD"), sourceDb, sourceTable),
		"--dest", fmt.Sprintf("h=%v,u=%v,p=%v,A=utf8mb4,D=%v,t=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD"), destDb, destTable),
		"--where", condition,
		"--bulk-delete", "--bulk-insert", "--commit-each",
		"--limit", batchSize,
		"--progress", batchSize,
		"--why-quit",
		"--statistics",
		"--no-delete",
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("archiveJob done")
}
