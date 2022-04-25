package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

// archiveStaleData runs pt-archive with bulk insert/delete enabled.
// It will archive data in sourceTable that is older than (now - daysBefore).
// Data is archived to destTable.
func archiveStaleData(sourceDb string, sourceTable string, destDb string, destTable string, daysBefore uint) {
	log.Println("archiveJob start")

	now := time.Now().UTC().Format(time.RFC3339)
	condition := fmt.Sprintf("create_time < '%v' - INTERVAL %v DAY", now, daysBefore)
	batchSize := "1000"

	log.Printf("source[%v.%v], dest[%v.%v] condition[%v] batchSize[%v]", sourceDb, sourceTable, destDb, destTable, condition, batchSize)

	cmd := exec.Command("pt-archiver",
		"--source", fmt.Sprintf("h=%v,u=%v,p=%v,A=utf8mb4,D=%v,t=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD"), sourceDb, sourceTable),
		"--dest", fmt.Sprintf("h=%v,u=%v,p=%v,A=utf8mb4,D=%v,t=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD"), destDb, destTable),
		"--where", condition,
		"--bulk-delete", "--bulk-insert", "--commit-each",
		"--limit", batchSize,
		"--why-quit",
		"--statistics",
		"--noversion-check",
		// "--progress", batchSize,
		// "--no-delete",
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("archiveJob done")
}
