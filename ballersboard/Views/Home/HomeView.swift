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
            .task{
                await viewModel.fetchClubs()
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Image(systemName: "crown.fill")
            }
            
        }
        
    }
    
}




#Preview {
    NavigationStack{
        HomeView()
    }
}
