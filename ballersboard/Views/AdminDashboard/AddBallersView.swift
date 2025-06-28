import SwiftUI

struct AddBallersView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var alias: String = ""
    @State private var amount: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6).ignoresSafeArea() // Match AdminDashboardView background

                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Text("Add New Baller")
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
                    .padding(.horizontal)
                    .padding(.top)

                    // Input Fields
                    VStack(spacing: 16) {
                        // Baller Name Input
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            TextField("Baller Name", text: $alias)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.words)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 2)

                        // Baller Amount Input
                        HStack {
                            Image(systemName: "nairasign.circle.fill")
                                .foregroundColor(.green)
                            TextField("Amount (₦)", text: $amount)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)

                    // Submit Button
                    Button {
                        // Validate and submit
                        guard !alias.isEmpty else {
                            alertMessage = "Please enter a baller name"
                            showAlert = true
                            return
                        }
                        guard let amount = Double(amount), amount >= 0 else {
                            alertMessage = "Please enter a valid amount"
                            showAlert = true
                            return
                        }
                        Task {
                            await viewModel.addBaller(alias: alias, amount: amount)
                            if !viewModel.showAlert { // Check if addBaller was successful
                                dismiss() // Close the view on success
                            } else {
                                alertMessage = viewModel.alertMessage
                                showAlert = true
                            }
                        }
                    } label: {
                        Text("Add Baller")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.isLoading)

                    Spacer()
                }
                .padding(.top)

                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    AddBallersView()
        .environmentObject(AuthViewModel())
}
