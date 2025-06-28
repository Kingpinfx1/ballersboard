import SwiftUI

struct ClubBallersView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let club: User
    @State private var ballers: [ClubBaller] = []

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
        ZStack {
            Color(.systemGray6).ignoresSafeArea() // Match AdminDashboardView background

            List {
                // Club Info Section
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(club.clubName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Text(club.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 2)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                }

                // Ballers Section
                Section(header:
                    HStack {
                        Text("Top Ballers")
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
                    if ballers.isEmpty {
                        Text("No ballers found")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(Array(ballers.enumerated()), id: \.element.id) { index, baller in
                            HStack(alignment: .center, spacing: 12) {
                                // Rank Indicator in Star Area
                                ZStack {
                                    Image(systemName: "star.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
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
                                    Text(baller.alias)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    if let formattedAmount = nairaFormatter.string(from: NSNumber(value: baller.amount)) {
                                        Text(formattedAmount)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    } else {
                                        Text("Invalid amount")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
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
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
            .refreshable {
                ballers = await viewModel.fetchBallersForUser(userId: club.id)
            }
            .task {
                ballers = await viewModel.fetchBallersForUser(userId: club.id)
                print("Task fetched \(ballers.count) ballers for club \(club.clubName)")
            }

            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
        .navigationTitle(club.clubName)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    ClubBallersView(club: User(id: "1", clubName: "Sample Club", city: "Lagos", address: "123 Street", socialLink: "example.com", phoneNumber: "1234567890", email: "sample@club.com", topBaller: nil))
        .environmentObject(AuthViewModel())
}
