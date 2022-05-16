package main

import (
	"sync"
	"time"

	"github.com/robfig/cron/v3"
)

func forever() {
	wg := sync.WaitGroup{}
	wg.Add(1)
	wg.Wait()
}

type ArchiveConfig []struct {
	srcSchema  string
	srcTable   string
	destSchema string
	destTable  string
}

func main() {
	initDatabase()
	defer db.Close()

	go idleProcessKiller("Worker|WebServer", 60)

	job := cron.New(cron.WithLocation(time.UTC))
	job.AddFunc("@every 5s", logDeadlock)
	job.AddFunc("@every 5s", logFkError)

	// var configs ArchiveConfig = ArchiveConfig{
	// 	{"Joker", "CashScoreBoard", "JokerArchive", "CashScoreBoard"},
	// 	{"Joker", "ExpScoreBoard", "JokerArchive", "ExpScoreBoard"},
	// 	{"Joker", "RankScoreBoard", "JokerArchive", "RankScoreBoard"},
	// 	{"Joker", "RichManScoreBoard", "JokerArchive", "RichManScoreBoard"},
	// 	{"Joker", "WinRateScoreBoard", "JokerArchive", "WinRateScoreBoard"},

	// 	{"Joker", "CashRecord", "JokerArchive", "CashRecord"},
	// 	{"Joker", "RankRecord", "JokerArchive", "RankRecord"},
	// 	{"Joker", "ExpRecord", "JokerArchive", "ExpRecord"},
	// 	{"Joker", "GoldRecord", "JokerArchive", "GoldRecord"},
	// 	{"Joker", "TicketRecord", "JokerArchive", "TicketRecord"},
	// 	{"Joker", "TransactionRecord", "JokerArchive", "TransactionRecord"},

	// 	{"Joker", "ClubDualMahjongGame", "JokerArchive", "ClubDualMahjongGame"},
	// 	{"Joker", "ClubMahjongGame", "JokerArchive", "ClubMahjongGame"},
	// 	{"Joker", "BuddyMahjongGame", "JokerArchive", "BuddyMahjongGame"},
	// 	{"Joker", "CommonDualMahjongGame", "JokerArchive", "CommonDualMahjongGame"},
	// 	{"Joker", "CommonMahjongGame", "JokerArchive", "CommonMahjongGame"},
	// 	{"Joker", "RankMahjongGame", "JokerArchive", "RankMahjongGame"},
	// 	{"Joker", "MissionGame", "JokerArchive", "MissionGame"},

	// 	{"Joker", "DualMahjongRoundRecord", "JokerArchive", "DualMahjongRoundRecord"},
	// 	{"Joker", "MahjongRoundRecord", "JokerArchive", "MahjongRoundRecord"},
	// }

	// archiveTimeSpec := "0 0 * * *"
	// var archiveDaysBefore uint = 60

	// for _, config := range configs {
	// 	srcSchema, srcTable := config.srcSchema, config.srcTable
	// 	destSchema, destTable := config.destSchema, config.destTable
	// 	archiveStaleData(srcSchema, srcTable, destSchema, destTable, archiveDaysBefore)
	// }

	// job.AddFunc(archiveTimeSpec, func() {
	// 	for _, config := range configs {
	// 		srcSchema, srcTable := config.srcSchema, config.srcTable
	// 		destSchema, destTable := config.destSchema, config.destTable
	// 		archiveStaleData(srcSchema, srcTable, destSchema, destTable, archiveDaysBefore)
	// 	}
	// })

	job.Start()

	forever()
}
