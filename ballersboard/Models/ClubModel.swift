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
