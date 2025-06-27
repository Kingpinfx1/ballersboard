//
//  HomeClubCardView.swift
//  ballersboard
//
//  Created by kingpin on 6/18/25.
//

import SwiftUI

struct HomeClubCardView: View {
    
    let club: User

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(club.clubName)
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundColor(.white)
                    Text(club.city)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if let baller = club.topBaller {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Top Baller")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        
                        Text("👑 \(baller.alias)")
                            .font(.system(.subheadline, design: .rounded).bold())
                            .foregroundColor(.yellow)
                        
                        Text("₦\(Int(baller.amount))")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                } else {
                    Text("No baller yet")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
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
//    HomeClubCardView(club: User(id: 1, clubName: "QUilox", city: "Lagos", address: "Lagos", socialLink: "instagram", phoneNumber: "0489274742", email: "test@gmail.com", clubLogo: "logourl"))
//}
