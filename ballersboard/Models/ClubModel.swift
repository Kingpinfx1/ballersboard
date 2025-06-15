//
//  ClubModel.swift
//  ballersboard
//
//  Created by kingpin on 6/15/25.
//


import Foundation

struct ClubModel: Identifiable, Codable {
    var id: String?
    let clubName: String
    let city: String
    let address: String
    let socialLink: String
    let phoneNumber: String
    let email: String
    let password: String
    let clubLogo: String
    var ballers: [ClubBaller] = []
    
    // Computed property - no Codable needed
    var topBaller: ClubBaller? {
        ballers.max(by: { $0.amount < $1.amount })
    }
}

struct ClubBaller: Identifiable, Codable {
    var id: String?
    let alias: String
    let amount: Double
}
