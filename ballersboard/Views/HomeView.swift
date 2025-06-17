//
//  HomeView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.softGray
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    List(viewModel.clubs) { club in
                        HomeClubCardView(club: club)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
                
            }
            .navigationTitle("Top clubs")
            .onAppear{
                viewModel.fetchClubs()
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Image(systemName: "crown.fill")
            }
            
        }
        
    }
    
}

private struct HomeClubCardView: View {
    
    let club: ClubModel

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
            Divider().background(Color.white.opacity(0.1))
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


#Preview {
    NavigationStack{
        HomeView()
    }
}
