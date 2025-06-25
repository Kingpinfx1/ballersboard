//
//  ClubModel.swift
//  ballersboard
//
//  Created by kingpin on 6/15/25.
//


import Foundation
import FirebaseFirestore

struct ClubModel: Identifiable, Codable {
    @DocumentID var id: String?
    var clubName: String
    var city: String
    var address: String
    var socialLink: String
    var phoneNumber: String
    var email: String
    var clubLogo: String? = nil
    var topBaller: ClubBaller?
}

struct ClubBaller: Identifiable, Codable {
    @DocumentID var id: String?
    var alias: String
    var amount: Double
}


extension ClubModel {
    static let sampleClubs: [ClubModel] = [
        ClubModel(
            id: "club1",
            clubName: "Club Velvet",
            city: "Miami",
            address: "123 Sunset Blvd, Miami Beach, FL",
            socialLink: "https://instagram.com/clubvelvet",
            phoneNumber: "+1 305-123-4567",
            email: "info@clubvelvet.com",
            clubLogo: "club1",
            topBaller: ClubBaller(id: "baller1", alias: "KingPin", amount: 5000)
        ),
        ClubModel(
            id: "club2",
            clubName: "The Vault",
            city: "Los Angeles",
            address: "789 Sunset Strip, Los Angeles, CA",
            socialLink: "https://instagram.com/thevaultla",
            phoneNumber: "+1 213-987-6543",
            email: "contact@thevaultla.com",
            clubLogo: "club2",
            topBaller: ClubBaller(id: "baller2", alias: "BigSpender", amount: 18000)
        ),
        ClubModel(
            id: "club3",
            clubName: "Sky Lounge",
            city: "New York City",
            address: "456 Empire Ave, New York, NY",
            socialLink: "https://instagram.com/skyloungeny",
            phoneNumber: "+1 212-555-7890",
            email: "sky@lounge.com",
            clubLogo: "club3",
            topBaller: ClubBaller(id: "baller3", alias: "NightOwl", amount: 32000)
        ),
        ClubModel(
            id: "club4",
            clubName: "Platinum",
            city: "Las Vegas",
            address: "321 Strip Road, Las Vegas, NV",
            socialLink: "https://instagram.com/platinumvegas",
            phoneNumber: "+1 702-222-8888",
            email: "platinum@vegasclub.com",
            clubLogo: "club4",
            topBaller: ClubBaller(id: "baller4", alias: "HighRoller", amount: 45000)
        ),
        ClubModel(
            id: "club5",
            clubName: "The Basement",
            city: "Chicago",
            address: "654 Underground Ln, Chicago, IL",
            socialLink: "https://instagram.com/thebasementchi",
            phoneNumber: "+1 773-123-9876",
            email: "basement@chicago.com",
            clubLogo: "club5",
            topBaller: ClubBaller(id: "baller5", alias: "WindyCity", amount: 12000)
        )
    ]
}

extension ClubBaller {
    static let sampleBallers: [ClubBaller] = [
        ClubBaller(id: "baller1", alias: "KingPin", amount: 5000),
        ClubBaller(id: "baller2", alias: "BigSpender", amount: 18000),
        ClubBaller(id: "baller3", alias: "NightOwl", amount: 32000),
        ClubBaller(id: "baller4", alias: "HighRoller", amount: 45000),
        ClubBaller(id: "baller5", alias: "WindyCity", amount: 12000)
    ]
}
