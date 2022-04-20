package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

func logDeadlock() {
	log.Println("deadlockLoggerJob start")

	cmd := exec.Command("pt-deadlock-logger",
		"--host", os.Getenv("DB_HOST"),
		"--user", os.Getenv("DB_USER"),
		"--password", os.Getenv("DB_PWD"),
		"--dest", fmt.Sprintf("D=%v,t=Deadlock", os.Getenv("DB_NAME")),
		"--iteration", "1",
		"--noversion-check",
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("deadlockLoggerJob done")
}

func logFkError() {
	log.Println("fkErrorLoggerJob start")

	cmd := exec.Command("pt-fk-error-logger",
		fmt.Sprintf("h=%v,u=%v,p=%v", os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PWD")),
		"--dest", fmt.Sprintf("D=%v,t=ForeignKeyError", os.Getenv("DB_NAME")),
		"--iteration", "1",
		"--noversion-check",
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		log.Printf("cmd.Run() failed with %s\n", err)
	}
	log.Println("fkErrorLoggerJob done")
}
