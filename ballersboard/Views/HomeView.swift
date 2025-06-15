//
//  HomeView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var clubSearch: String = ""
    @State private var clubs = Club.sampleClubs
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepBlack
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    clubList
                }
                .searchable(text: $clubSearch, prompt: "Search clubs or top ballers")
            }
            .navigationTitle("Top clubs")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Image(systemName: "crown.fill")
            }
            
        }
        
    }
    
//    private var filteredClubs: [Club] {
//        if clubSearch.isEmpty {
//            return clubs
//        } else {
//            return clubs.filter {
//                $0.name.localizedCaseInsensitiveContains(clubSearch) ||
//                $0.city.localizedCaseInsensitiveContains(clubSearch) ||
//                $0.topBaller.alias.localizedCaseInsensitiveContains(clubSearch)
//            }
//        }
    
    private var filteredClubs: [Club] {
        let result = clubSearch.isEmpty
            ? clubs
            : clubs.filter {
                $0.name.localizedCaseInsensitiveContains(clubSearch) ||
                $0.city.localizedCaseInsensitiveContains(clubSearch) ||
                $0.topBaller.alias.localizedCaseInsensitiveContains(clubSearch)
            }
        
        return result.sorted { $0.topBaller.amount > $1.topBaller.amount }
    }

}

struct ClubCardView: View {
    
    let club: Club
    
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
                Text(club.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(club.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "crown.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("Top: \(club.topBaller.alias)")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("$\(Int(club.topBaller.amount))")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
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

extension HomeView{
    private var homeViewHeader: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("Top Clubs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.softWhite)
            
            Spacer()
            
            Image(systemName: "crown.fill")
                .font(.title)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var clubList: some View{
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredClubs) { club in
                    NavigationLink(destination: ClubDetailView(club: club)) {
                        ClubCardView(club: club)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
