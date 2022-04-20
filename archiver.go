package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

func archiveStaleData(sourceDb string, sourceTable string, destDb string, destTable string, daysBefore uint) {
	log.Println("archiveJob start")

	now := time.Now().UTC().Format(time.RFC3339)
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
		"--noversion-check",
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("archiveJob done")
}
