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

// EventItemReceiveRecord may be a long term event
// Create archive table, but no move record now

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
		{"Joker", "CampaignScoreboard", "JokerArchive", "CampaignScoreboard"},

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
		{"Joker", "ItemConsumeRecord", "JokerArchive", "ItemConsumeRecord"},
		{"Joker", "CurrencyRecord", "JokerArchive", "CurrencyRecord"},
		{"Joker", "VipExpRecord", "JokerArchive", "VipExpRecord"},
		{"Joker", "VipMissionRecord", "JokerArchive", "VipMissionRecord"},

		{"Joker", "CommonDualMahjongGame", "JokerArchive", "CommonDualMahjongGame"},
		{"Joker", "ClubDualMahjongGame", "JokerArchive", "ClubDualMahjongGame"},
		{"Joker", "BuddyDualMahjongGame", "JokerArchive", "BuddyDualMahjongGame"},

		{"Joker", "CommonMahjongGame", "JokerArchive", "CommonMahjongGame"},
		{"Joker", "ClubMahjongGame", "JokerArchive", "ClubMahjongGame"},
		{"Joker", "BuddyMahjongGame", "JokerArchive", "BuddyMahjongGame"},
		{"Joker", "RankMahjongGame", "JokerArchive", "RankMahjongGame"},
		{"Joker", "CarnivalMahjongGame", "JokerArchive", "CarnivalMahjongGame"},
		{"Joker", "MissionGame", "JokerArchive", "MissionGame"},
		{"Joker", "NewCommonMahjongGame", "JokerArchive", "NewCommonMahjongGame"},
		{"Joker", "NewBuddyMahjongGame", "JokerArchive", "NewBuddyMahjongGame"},
		{"Joker", "NewCarnivalMahjongGame", "JokerArchive", "NewCarnivalMahjongGame"},
		{"Joker", "NewRankMahjongGame", "JokerArchive", "NewRankMahjongGame"},
		{"Joker", "NewQualifierMahjongGame", "JokerArchive", "NewQualifierMahjongGame"},
		{"Joker", "NewEliminationMahjongGame", "JokerArchive", "NewEliminationMahjongGame"},
		{"Joker", "NewClubMahjongGame", "JokerArchive", "NewClubMahjongGame"},
		{"Joker", "BuddyHorseRaceMahjongGame", "JokerArchive", "BuddyHorseRaceMahjongGame"},
		{"Joker", "CommonHorseRaceMahjongGame", "JokerArchive", "CommonHorseRaceMahjongGame"},
		{"Joker", "ClubHorseRaceMahjongGame", "JokerArchive", "ClubHorseRaceMahjongGame"},

		{"Joker", "DualMahjongRoundRecord", "JokerArchive", "DualMahjongRoundRecord"},
		{"Joker", "MahjongRoundRecord", "JokerArchive", "MahjongRoundRecord"},
		{"Joker", "NewMahjongRoundRecord", "JokerArchive", "NewMahjongRoundRecord"},
		{"Joker", "HorseRaceMahjongRoundRecord", "JokerArchive", "HorseRaceMahjongRoundRecord"},

		{"Joker", "BuddyYablonBet", "JokerArchive", "BuddyYablonBet"},
		{"Joker", "CommonYablonBet", "JokerArchive", "CommonYablonBet"},
		{"Joker", "ClubYablonBet", "JokerArchive", "ClubYablonBet"},
		{"Joker", "BuddyTexasPokerBet", "JokerArchive", "BuddyTexasPokerBet"},
		{"Joker", "CommonTexasPokerBet", "JokerArchive", "CommonTexasPokerBet"},
		{"Joker", "ClubTexasPokerBet", "JokerArchive", "ClubTexasPokerBet"},
		{"Joker", "CommonZoomTexasPokerBet", "JokerArchive", "CommonZoomTexasPokerBet"},

		{"Joker", "BuddyYablonGame", "JokerArchive", "BuddyYablonGame"},
		{"Joker", "CommonYablonGame", "JokerArchive", "CommonYablonGame"},
		{"Joker", "ClubYablonGame", "JokerArchive", "ClubYablonGame"},

		{"Joker", "CommonChinesePokerRoundRecord", "JokerArchive", "CommonChinesePokerRoundRecord"},
		{"Joker", "ClubChinesePokerRoundRecord", "JokerArchive", "ClubChinesePokerRoundRecord"},
		{"Joker", "BuddyChinesePokerRoundRecord", "JokerArchive", "BuddyChinesePokerRoundRecord"},
		{"Joker", "CommonDarkChessRoundRecord", "JokerArchive", "CommonDarkChessRoundRecord"},
		{"Joker", "BuddyDarkChessRoundRecord", "JokerArchive", "BuddyDarkChessRoundRecord"},
		{"Joker", "QualifierChinesePokerRoundRecord", "JokerArchive", "QualifierChinesePokerRoundRecord"},
		{"Joker", "EliminationChinesePokerRoundRecord", "JokerArchive", "EliminationChinesePokerRoundRecord"},

		{"Joker", "CommonChinesePokerGame", "JokerArchive", "CommonChinesePokerGame"},
		{"Joker", "ClubChinesePokerGame", "JokerArchive", "ClubChinesePokerGame"},
		{"Joker", "BuddyChinesePokerGame", "JokerArchive", "BuddyChinesePokerGame"},
		{"Joker", "CommonDarkChessGame", "JokerArchive", "CommonDarkChessGame"},
		{"Joker", "BuddyDarkChessGame", "JokerArchive", "BuddyDarkChessGame"},
		{"Joker", "BuddyTexasPokerGame", "JokerArchive", "BuddyTexasPokerGame"},
		{"Joker", "CommonTexasPokerGame", "JokerArchive", "CommonTexasPokerGame"},
		{"Joker", "ClubTexasPokerGame", "JokerArchive", "ClubTexasPokerGame"},
		{"Joker", "CommonZoomTexasPokerGame", "JokerArchive", "CommonZoomTexasPokerGame"},
		{"Joker", "QualifierChinesePokerGame", "JokerArchive", "QualifierChinesePokerGame"},
		{"Joker", "EliminationChinesePokerGame", "JokerArchive", "EliminationChinesePokerGame"},

		{"Joker", "RouletteTransferInRecord", "JokerArchive", "RouletteTransferInRecord"},
		{"Joker", "RouletteTransferOutRecord", "JokerArchive", "RouletteTransferOutRecord"},
		{"Joker", "TexasPokerJackpotTransferOutRecord", "JokerArchive", "TexasPokerJackpotTransferOutRecord"},

		{"Joker", "PiggyBankCoinRecord", "JokerArchive", "PiggyBankCoinRecord"},
		{"Joker", "CampaignPrizeRecord", "JokerArchive", "CampaignPrizeRecord"},
		{"Joker", "CampaignMissionRecord", "JokerArchive", "CampaignMissionRecord"},
		{"Joker", "UserPointRecord", "JokerArchive", "UserPointRecord"},
		{"Joker", "PointShopRecord", "JokerArchive", "PointShopRecord"},
		{"Joker", "NameChangedRecord", "JokerArchive", "NameChangedRecord"},
		{"Joker", "MoonCardMissionRecord", "JokerArchive", "MoonCardMissionRecord"},
		{"Joker", "PrizeRecord", "JokerArchive", "PrizeRecord"},

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
