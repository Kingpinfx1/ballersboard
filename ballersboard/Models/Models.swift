//
//  Models.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import Foundation

struct Club: Identifiable {
    let id = UUID()
    let name: String
    let city: String
    let logo: String // Placeholder for image name
    let ballers: [Baller]
    
    var topBaller: Baller {
        ballers.max(by: { $0.amount < $1.amount }) ?? ballers.first!
    }
}

struct Baller: Identifiable {
    let id = UUID()
    let alias: String
    let amount: Double
    let timestamp: Date
    let crownedTime: String
}

extension Club {
    static let sampleClubs: [Club] = [
        Club(
            name: "Club Velvet",
            city: "Miami",
            logo: "club1",
            ballers: [
                Baller(alias: "KingPin", amount: 5000, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "SmoothJay", amount: 3200, timestamp: Date(), crownedTime: "4h ago"),
                Baller(alias: "IceMoney", amount: 4200, timestamp: Date(), crownedTime: "1h ago"),
                Baller(alias: "DripGod", amount: 1500, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "StacksOnly", amount: 2800, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "VelvetVibes", amount: 6000, timestamp: Date(), crownedTime: "20m ago"),
                Baller(alias: "DJStacks", amount: 3300, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "NoCap", amount: 2100, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "YungCash", amount: 3700, timestamp: Date(), crownedTime: "6h ago"),
                Baller(alias: "Wavey", amount: 1900, timestamp: Date(), crownedTime: "7h ago"),
                Baller(alias: "BigTunez", amount: 2700, timestamp: Date(), crownedTime: "8h ago")
            ]
        ),
        Club(
            name: "The Vault",
            city: "LA",
            logo: "club2",
            ballers: [
                Baller(alias: "BigSpender", amount: 18000, timestamp: Date(), crownedTime: "1h ago"),
                Baller(alias: "WestSide", amount: 9200, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "LilStack", amount: 11000, timestamp: Date(), crownedTime: "30m ago"),
                Baller(alias: "Cashanova", amount: 12500, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "BeverlyKing", amount: 8800, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "LaFlare", amount: 10500, timestamp: Date(), crownedTime: "4h ago"),
                Baller(alias: "GoldRush", amount: 11700, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "RealRich", amount: 10200, timestamp: Date(), crownedTime: "6h ago"),
                Baller(alias: "LAStacks", amount: 9100, timestamp: Date(), crownedTime: "7h ago"),
                Baller(alias: "VaultBoy", amount: 8700, timestamp: Date(), crownedTime: "8h ago"),
                Baller(alias: "CaliCrown", amount: 9400, timestamp: Date(), crownedTime: "9h ago")
            ]
        ),
        Club(
            name: "Sky Lounge",
            city: "NYC",
            logo: "club3",
            ballers: [
                Baller(alias: "NightOwl", amount: 32000, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "HighLife", amount: 22000, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "GothamRich", amount: 28000, timestamp: Date(), crownedTime: "1h ago"),
                Baller(alias: "Skyliner", amount: 25000, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "CloudBoss", amount: 21000, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "EmpireBaller", amount: 19500, timestamp: Date(), crownedTime: "4h ago"),
                Baller(alias: "NYStacks", amount: 27000, timestamp: Date(), crownedTime: "30m ago"),
                Baller(alias: "SohoKing", amount: 24000, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "UptownFly", amount: 26000, timestamp: Date(), crownedTime: "6h ago"),
                Baller(alias: "CityFlex", amount: 20000, timestamp: Date(), crownedTime: "7h ago"),
                Baller(alias: "HarlemGold", amount: 23000, timestamp: Date(), crownedTime: "8h ago")
            ]
        ),
        Club(
            name: "Platinum",
            city: "Vegas",
            logo: "club4",
            ballers: [
                Baller(alias: "HighRoller", amount: 45000, timestamp: Date(), crownedTime: "30m ago"),
                Baller(alias: "LuckyLeo", amount: 38000, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "VivaCash", amount: 40000, timestamp: Date(), crownedTime: "1h ago"),
                Baller(alias: "CasinoKing", amount: 37000, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "BlackJack", amount: 36000, timestamp: Date(), crownedTime: "4h ago"),
                Baller(alias: "JackpotJay", amount: 39000, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "ChipMaster", amount: 41000, timestamp: Date(), crownedTime: "6h ago"),
                Baller(alias: "RollingDice", amount: 33000, timestamp: Date(), crownedTime: "7h ago"),
                Baller(alias: "SinCity", amount: 34000, timestamp: Date(), crownedTime: "8h ago"),
                Baller(alias: "GoldenBet", amount: 42000, timestamp: Date(), crownedTime: "9h ago"),
                Baller(alias: "VegasFlash", amount: 39000, timestamp: Date(), crownedTime: "10h ago")
            ]
        ),
        Club(
            name: "The Basement",
            city: "Chicago",
            logo: "club5",
            ballers: [
                Baller(alias: "WindyCity", amount: 12000, timestamp: Date(), crownedTime: "4h ago"),
                Baller(alias: "ChiKing", amount: 15000, timestamp: Date(), crownedTime: "3h ago"),
                Baller(alias: "DeepStacks", amount: 10000, timestamp: Date(), crownedTime: "2h ago"),
                Baller(alias: "BasementBoss", amount: 9000, timestamp: Date(), crownedTime: "1h ago"),
                Baller(alias: "SouthSide", amount: 8000, timestamp: Date(), crownedTime: "5h ago"),
                Baller(alias: "ChiStacks", amount: 11000, timestamp: Date(), crownedTime: "6h ago"),
                Baller(alias: "DrippyDre", amount: 7000, timestamp: Date(), crownedTime: "7h ago"),
                Baller(alias: "NorthFlex", amount: 9500, timestamp: Date(), crownedTime: "8h ago"),
                Baller(alias: "MidWestMoney", amount: 8700, timestamp: Date(), crownedTime: "9h ago"),
                Baller(alias: "BasementBandit", amount: 10500, timestamp: Date(), crownedTime: "10h ago"),
                Baller(alias: "ChiCrown", amount: 11300, timestamp: Date(), crownedTime: "11h ago")
            ]
        )
    ]
}

extension Baller {
    static let sampleBallers: [Baller] = [
        Baller(alias: "KingPin", amount: 5000, timestamp: Date(), crownedTime: "2h ago"),
        Baller(alias: "SmoothJay", amount: 3200, timestamp: Date(), crownedTime: "4h ago"),
        Baller(alias: "IceMoney", amount: 4200, timestamp: Date(), crownedTime: "1h ago"),
        Baller(alias: "DripGod", amount: 1500, timestamp: Date(), crownedTime: "5h ago"),
        Baller(alias: "StacksOnly", amount: 2800, timestamp: Date(), crownedTime: "3h ago"),
        Baller(alias: "VelvetVibes", amount: 6000, timestamp: Date(), crownedTime: "20m ago"),
        Baller(alias: "DJStacks", amount: 3300, timestamp: Date(), crownedTime: "2h ago"),
        Baller(alias: "NoCap", amount: 2100, timestamp: Date(), crownedTime: "3h ago"),
        Baller(alias: "YungCash", amount: 3700, timestamp: Date(), crownedTime: "6h ago"),
        Baller(alias: "Wavey", amount: 1900, timestamp: Date(), crownedTime: "7h ago"),
        Baller(alias: "BigTunez", amount: 2700, timestamp: Date(), crownedTime: "8h ago")
    ]
}
