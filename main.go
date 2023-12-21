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

	var configs ArchiveConfig = ArchiveConfig{
		{"Joker", "CashScoreBoard", "JokerArchive", "CashScoreBoard"},
		{"Joker", "ExpScoreBoard", "JokerArchive", "ExpScoreBoard"},
		{"Joker", "RankScoreBoard", "JokerArchive", "RankScoreBoard"},
		{"Joker", "RichManScoreBoard", "JokerArchive", "RichManScoreBoard"},
		{"Joker", "WinRateScoreBoard", "JokerArchive", "WinRateScoreBoard"},
		{"Joker", "ClubCashScoreboard", "JokerArchive", "ClubCashScoreboard"},
		{"Joker", "MissionGameScoreBoard", "JokerArchive", "MissionGameScoreBoard"},

		{"Joker", "CashRecord", "JokerArchive", "CashRecord"},
		{"Joker", "RankRecord", "JokerArchive", "RankRecord"},
		{"Joker", "ExpRecord", "JokerArchive", "ExpRecord"},
		{"Joker", "GoldRecord", "JokerArchive", "GoldRecord"},
		{"Joker", "TicketRecord", "JokerArchive", "TicketRecord"},
		{"Joker", "TransactionRecord", "JokerArchive", "TransactionRecord"},
		{"Joker", "MarbleRecord", "JokerArchive", "MarbleRecord"},
		{"Joker", "ItemPurchaseRecord", "JokerArchive", "ItemPurchaseRecord"},
		{"Joker", "BundlePurchaseRecord", "JokerArchive", "BundlePurchaseRecord"},
		{"Joker", "GachaRecord", "JokerArchive", "GachaRecord"},
		{"Joker", "ItemExchangeRecord", "JokerArchive", "ItemExchangeRecord"},
		{"Joker", "AchievementShopPurchaseRecord", "JokerArchive", "AchievementShopPurchaseRecord"},
		{"Joker", "CarnivalShopPurchaseRecord", "JokerArchive", "CarnivalShopPurchaseRecord"},

		{"Joker", "CommonDualMahjongGame", "JokerArchive", "CommonDualMahjongGame"},
		{"Joker", "ClubDualMahjongGame", "JokerArchive", "ClubDualMahjongGame"},
		{"Joker", "BuddyDualMahjongGame", "JokerArchive", "BuddyDualMahjongGame"},

		{"Joker", "CommonMahjongGame", "JokerArchive", "CommonMahjongGame"},
		{"Joker", "ClubMahjongGame", "JokerArchive", "ClubMahjongGame"},
		{"Joker", "BuddyMahjongGame", "JokerArchive", "BuddyMahjongGame"},
		{"Joker", "RankMahjongGame", "JokerArchive", "RankMahjongGame"},
		{"Joker", "CarnivalMahjongGame", "JokerArchive", "CarnivalMahjongGame"},
		{"Joker", "MissionGame", "JokerArchive", "MissionGame"},

		{"Joker", "DualMahjongRoundRecord", "JokerArchive", "DualMahjongRoundRecord"},
		{"Joker", "MahjongRoundRecord", "JokerArchive", "MahjongRoundRecord"},

		{"Joker", "BuddyYablonBet", "JokerArchive", "BuddyYablonBet"},
		{"Joker", "CommonYablonBet", "JokerArchive", "CommonYablonBet"},
		{"Joker", "ClubYablonBet", "JokerArchive", "ClubYablonBet"},
		{"Joker", "BuddyTexasPokerBet", "JokerArchive", "BuddyTexasPokerBet"},
		{"Joker", "CommonTexasPokerBet", "JokerArchive", "CommonTexasPokerBet"},
		{"Joker", "ClubTexasPokerBet", "JokerArchive", "ClubTexasPokerBet"},

		{"Joker", "BuddyYablonGame", "JokerArchive", "BuddyYablonGame"},
		{"Joker", "CommonYablonGame", "JokerArchive", "CommonYablonGame"},
		{"Joker", "ClubYablonGame", "JokerArchive", "ClubYablonGame"},

		{"Joker", "CommonChinesePokerRoundRecord", "JokerArchive", "CommonChinesePokerRoundRecord"},
		{"Joker", "ClubChinesePokerRoundRecord", "JokerArchive", "ClubChinesePokerRoundRecord"},
		{"Joker", "BuddyChinesePokerRoundRecord", "JokerArchive", "BuddyChinesePokerRoundRecord"},
		{"Joker", "CommonDarkChessRoundRecord", "JokerArchive", "CommonDarkChessRoundRecord"},
		{"Joker", "BuddyDarkChessRoundRecord", "JokerArchive", "BuddyDarkChessRoundRecord"},

		{"Joker", "CommonChinesePokerGame", "JokerArchive", "CommonChinesePokerGame"},
		{"Joker", "ClubChinesePokerGame", "JokerArchive", "ClubChinesePokerGame"},
		{"Joker", "BuddyChinesePokerGame", "JokerArchive", "BuddyChinesePokerGame"},
		{"Joker", "CommonDarkChessGame", "JokerArchive", "CommonDarkChessGame"},
		{"Joker", "BuddyDarkChessGame", "JokerArchive", "BuddyDarkChessGame"},
		{"Joker", "BuddyTexasPokerGame", "JokerArchive", "BuddyTexasPokerGame"},
		{"Joker", "CommonTexasPokerGame", "JokerArchive", "CommonTexasPokerGame"},
		{"Joker", "ClubTexasPokerGame", "JokerArchive", "ClubTexasPokerGame"},

		{"Joker", "RouletteTransferInRecord", "JokerArchive", "RouletteTransferInRecord"},
		{"Joker", "RouletteTransferOutRecord", "JokerArchive", "RouletteTransferOutRecord"},
		{"Joker", "TexasPokerJackpotTransferOutRecord", "JokerArchive", "TexasPokerJackpotTransferOutRecord"},

		{"Joker", "OnlineRecord", "JokerArchive", "OnlineRecord"},
		{"Joker", "ClubOperateLog", "JokerArchive", "ClubOperateLog"},
		{"Joker", "GoldReportSummary", "JokerArchive", "GoldReportSummary"},
	}

	archiveTimeSpec := "0 0 * * *"
	var archiveDaysBefore uint = 60

	// Run archiver on startup (simply for checking whether it will work)
	for _, config := range configs {
		srcSchema, srcTable := config.srcSchema, config.srcTable
		destSchema, destTable := config.destSchema, config.destTable
		archiveStaleData(srcSchema, srcTable, destSchema, destTable, archiveDaysBefore)
	}

	job.AddFunc(archiveTimeSpec, func() {
		for _, config := range configs {
			srcSchema, srcTable := config.srcSchema, config.srcTable
			destSchema, destTable := config.destSchema, config.destTable
			archiveStaleData(srcSchema, srcTable, destSchema, destTable, archiveDaysBefore)
		}
	})

	job.Start()

	forever()
}
