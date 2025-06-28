import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var clubs: [(user: User, topBallerAmount: Double?)] = []

    // NumberFormatter for Naira
    private let nairaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_NG") // Nigerian Naira
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea() // Match AdminDashboardView background

                List {
                    // Clubs Section
                    Section(header:
                        HStack {
                            Text("Top Clubs")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    ) {
                        if clubs.isEmpty {
                            Text("No clubs found")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(Array(clubs.enumerated()), id: \.element.user.id) { index, club in
                                NavigationLink(destination: ClubBallersView(club: club.user)
                                    .environmentObject(viewModel)) {
                                    HStack(alignment: .center, spacing: 12) {
                                        // Rank Indicator in Crown Area
                                        ZStack {
                                            Image(systemName: "crown.fill")
                                                .resizable()
                                                .frame(width: 40, height: 30)
                                                .foregroundColor(.yellow)
                                            Text("\(index + 1)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .padding(4)
                                                .background(Circle().fill(Color.white.opacity(0.8)))
                                                .offset(x: 10, y: -10)
                                        }
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(club.user.clubName)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Text(club.user.email)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            if let amount = club.topBallerAmount,
                                               let formattedAmount = nairaFormatter.string(from: NSNumber(value: amount)) {
                                                Text("Top Baller: \(formattedAmount)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            } else {
                                                Text("No top baller")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 2)
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                }
                .refreshable {
                    clubs = await viewModel.fetchClubs()
                }
                .task {
                    clubs = await viewModel.fetchClubs()
                    print("Task fetched \(clubs.count) clubs")
                }

                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Top Clubs")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                ToolbarItem(placement: .primaryAction) {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.yellow)
                }
            }
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
