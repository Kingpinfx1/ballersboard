//
//  AdminDashboardView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct AdminDashboardView: View {
    @State private var ballers = Baller.sampleBallers
    @State private var newBallerAlias = ""
    @State private var newBallerAmount = ""
    @State private var showingAddForm = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                    
                    clubInfoCard
                    
                    ballersList
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
    
}

extension AdminDashboardView{
    // MARK: HEADER
    private var header: some View{
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("Admin Dashboard")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                showingAddForm.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var clubInfoCard: some View {
        HStack(spacing: 16) {
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Club Velvet")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text("Miami, FL")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "crown.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("Top Baller: KingPin")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Spacer()
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
        .padding(.horizontal, 20)
        .padding(.top, 16)
        
    }
    
    private var ballersList: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Top Ballers")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Read Only")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                    )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(Array(ballers.enumerated()), id: \.element.id) { index, baller in
                        AdminBallerRowView(baller: baller, rank: index + 1)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct AdminBallerRowView: View {
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

struct AddBallerFormView: View {
    @Binding var alias: String
    @Binding var amount: String
    @Binding var isVisible: Bool
    let onAdd: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Add New Baller")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    isVisible = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            
            VStack(spacing: 16) {
                CustomTextField(title: "Baller Alias", text: $alias, placeholder: "Enter baller alias")
                
                CustomTextField(title: "Amount Spent", text: $amount, placeholder: "Enter amount")
                    .keyboardType(.decimalPad)
            }
            
            Button(action: onAdd) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                    Text("Add Baller")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.green)
                .cornerRadius(12)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
}

#Preview {
    AdminDashboardView()
} 
