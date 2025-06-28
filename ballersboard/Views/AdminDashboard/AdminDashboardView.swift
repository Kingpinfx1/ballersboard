import SwiftUI

struct AdminDashboardView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showDeleteConfirmation = false
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
        NavigationView {
            ZStack {
                Color(.systemGray6).ignoresSafeArea() // Light background for contrast

                if let user = viewModel.currentUser {
                    List {
                        // User Profile Section
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.blue)
                                    VStack(alignment: .leading) {
                                        Text(user.clubName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        Text(user.email)
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
                                Text("Club Ballers")
                                    .font(.headline)
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

                        // Account Actions Section
                        Section(header: Text("Account").font(.headline)) {
                            Button {
                                viewModel.signOut()
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.left.circle.fill")
                                        .foregroundColor(.red)
                                    Text("Sign out")
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                            }
                            .disabled(viewModel.isLoading)

                            Button {
                                showDeleteConfirmation = true
                            } label: {
                                HStack {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                    Text("Delete account")
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                            }
                            .disabled(viewModel.isLoading)
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
                    .refreshable {
                        await viewModel.reloadUser()
                        ballers = await viewModel.fetchBallers()
                    }
                    .task {
                        ballers = await viewModel.fetchBallers()
                        print("Task fetched \(ballers.count) ballers")
                    }
                }

                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Profile")
            .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    Task {
                        await viewModel.deleteAccount()
                    }
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone.")
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
    AdminDashboardView()
        .environmentObject(AuthViewModel())
}


































//
//import SwiftUI
//
//struct AdminDashboardView: View {
//    
//    @EnvironmentObject var viewModel : AuthViewModel
//    @State private var showDeleteConfirmation = false
//    @State private var ballers : [ClubBaller] =  []
//
//    var body: some View {
//        if let user = viewModel.currentUser{
//            ZStack {
//                List {
//                    Section{
//                        HStack{
//                           
//                            
//                            VStack{
//                                Text(user.clubName)
//                                    .fontWeight(.bold)
//                                Text(user.email)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                    
//                    // New Section for Ballers
//                                        Section(header: Text("Club Ballers")) {
//                                            if ballers.isEmpty {
//                                                Text("No ballers found")
//                                                    .foregroundColor(.gray)
//                                            } else {
//                                                ForEach(ballers) { baller in
//                                                    VStack(alignment: .leading) {
//                                                        Text(baller.alias)
//                                                            .fontWeight(.semibold)
//                                                        Text("Amount: $\(String(format: "%.2f", baller.amount))")
//                                                            .font(.caption)
//                                                    }
//                                                }
//                                            }
//                                        }
//                    
//                    Section("Account"){
//                        
//                        Button {
//                            viewModel.signOut()
//                        } label: {
//                            HStack{
//                                Image(systemName: "arrow.left.circle.fill")
//                                Text("Sign out")
//                            }
//                            .foregroundStyle(.red)
//                        }
//                        .disabled(viewModel.isLoading)
//                        
//                        Button {
//                            showDeleteConfirmation = true
//                        } label: {
//                            HStack{
//                                Image(systemName: "xmark.circle.fill")
//                                Text("Delete account")
//                            }
//                            .foregroundStyle(.red)
//                        }
//                        .disabled(viewModel.isLoading)
//                        
//                    }
//                }
//                .refreshable {
//                    await viewModel.reloadUser()
//                    ballers = await viewModel.fetchBallers()
//                }
//                .task {
//                    ballers =  await viewModel.fetchBallers()
//                }
//                
//                if viewModel.isLoading {
//                    Color.black.opacity(0.4)
//                        .ignoresSafeArea()
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                        .scaleEffect(1.5)
//                }
//            }
//            .alert("Delete Account", isPresented: $showDeleteConfirmation) {
//                Button("Cancel", role: .cancel) { }
//                Button("Delete", role: .destructive) {
//                    Task {
//                        await viewModel.deleteAccount()
//                    }
//                }
//            } message: {
//                Text("Are you sure you want to delete your account? This action cannot be undone.")
//            }
//            .alert("Error", isPresented: $viewModel.showAlert) {
//                Button("OK", role: .cancel) { }
//            } message: {
//                Text(viewModel.alertMessage)
//            }
//
//        }
//    }
//}
//
//#Preview {
//    AdminDashboardView()
//        .environmentObject(AuthViewModel())
//}
