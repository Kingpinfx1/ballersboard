//
//  ClubCardView.swift
//  ballersboard
//
//  Created by kingpin on 6/15/25.
//

import SwiftUI

struct ClubCardView: View {
    
    let club: ClubModel
    
    var body: some View {
        HStack(spacing: 16) {
            // Club Logo
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.pink]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: "building.2.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            // Club Info
            VStack(alignment: .leading, spacing: 4) {
                Text(club.clubName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(club.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
//                HStack {
//                    Image(systemName: "crown.fill")
//                        .font(.caption)
//                        .foregroundColor(.yellow)
//                    
//                    Text("Top: \(club.)")
//                        .font(.caption)
//                        .foregroundColor(.yellow)
//                    
//                    Text("$\(Int(club.topBaller.amount))")
//                        .font(.caption)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.green)
//                }
            }
            
            Spacer()
            
            // Arrow
            Image(systemName: "chevron.right")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

//#Preview {
//    ClubCardView(club: Club(
//        name: "Club Royale",
//        city: "Lagos",
//        logo: "club_logo",
//        ballers: [
//            Baller(alias: "KingPin", amount: 5000, timestamp: Date(), crownedTime: "2h ago"),
//            Baller(alias: "SmoothJay", amount: 3000, timestamp: Date(), crownedTime: "3h ago")
//        ]
//    ))
//}
