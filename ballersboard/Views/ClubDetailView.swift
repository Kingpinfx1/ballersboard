//
//  ClubDetailView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct ClubDetailView: View {
    
    let club: Club
    //@State private var ballers = Baller.sampleBallers
    @State private var ballers = Baller.sampleBallers.sorted { $0.amount > $1.amount }

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
       
            ZStack {
                Color.deepBlack
                    .ignoresSafeArea()
            
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16){
                            
                            header
                                .padding(.top, 16)
                            
                            clubInfoCard
                            
                            Text("Top Ballers")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(Array(ballers.enumerated()), id: \.element.id) { index, baller in
                                    BallerRowView(baller: baller, rank: index + 1)
                                }
                            }
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, 20)
                
            }
            .navigationBarHidden(true)
    }
    
    private var topBaller: Baller? {
        ballers.max(by: {$0.amount < $1.amount})
    }
    
}


struct BallerRowView: View {
    
    let baller: Baller
    let rank: Int
    
    var body: some View {
        HStack(spacing: 16) {
            // Rank
            ZStack {
                Circle()
                    .fill(rankColor)
                    .frame(width: 40, height: 40)
                
                Text("\(rank)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            // Baller Info
            VStack(alignment: .leading, spacing: 4) {
                Text(baller.alias)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "clock.fill")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Crowned \(baller.crownedTime)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Amount
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(Int(baller.amount))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                if rank == 1 {
                    HStack {
                        Image(systemName: "crown.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        
                        Text("KING")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .purple
        }
    }
}

extension ClubDetailView{
    
    private var header: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
//                Text(club.name)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                
//                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "crown.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private var clubInfoCard : some View {
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
                    .frame(width: 80, height: 80)
                
                Image(systemName: "building.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(club.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(club.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let top = topBaller{
                    HStack {
                        Image(systemName: "crown.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        
                        Text("Top Baller: \(top.alias)")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ClubDetailView(club: Club.sampleClubs[0])
}
