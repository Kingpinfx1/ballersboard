//
//  ClubAuthView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct ClubAuthView: View {
    @State private var selectedTab = 0
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToSignup = false
    @State private var navigateToDashboard = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Header
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
                            
                            Text("Club Access")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "questionmark.circle")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Segmented Control
                        Picker("Auth Type", selection: $selectedTab) {
                            Text("Login").tag(0)
                            Text("Sign Up").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    if selectedTab == 0 {
                        // Login Form
                        LoginFormView(
                            email: $email,
                            password: $password,
                            navigateToDashboard: $navigateToDashboard
                        )
                    } else {
                        // Signup Option
                        SignupOptionView(navigateToSignup: $navigateToSignup)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToSignup) {
                ClubSignupView()
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                AdminDashboardView()
            }
        }
    }
}

struct LoginFormView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var navigateToDashboard: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Club Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.pink]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Image(systemName: "building.2.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            
            // Form Fields
            VStack(spacing: 16) {
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                }
            }
            .padding(.horizontal, 20)
            
            // Login Button
            Button(action: {
                navigateToDashboard = true
            }) {
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.title2)
                    Text("Login")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.white)
                .cornerRadius(16)
            }
            .padding(.horizontal, 20)
            
            // Forgot Password
            Button(action: {}) {
                Text("Forgot Password?")
                    .font(.subheadline)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct SignupOptionView: View {
    @Binding var navigateToSignup: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 16) {
                Text("New Club?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Create your club profile and start tracking your top ballers")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            // Signup Button
            Button(action: {
                navigateToSignup = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                    Text("Create Club Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.purple)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )
            .foregroundColor(.white)
    }
}

#Preview {
    ClubAuthView()
} 