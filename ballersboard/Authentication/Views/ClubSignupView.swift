//
//  ClubSignupView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct ClubSignupView: View {
    @State private var clubName = ""
    @State private var city = ""
    @State private var address = ""
    @State private var socialLink = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var clubLogo = false
    @State private var navigateToDashboard = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        header
                        
                        signUpIcon
                        
                        signUpForm
                        
                        submitButton
                       
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToDashboard) {
                AdminDashboardView()
            }
        }
    }
}
extension ClubSignupView {
    
    private var header : some View{
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("Club Registration")
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
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        
    }
    
    private var signUpIcon : some View {
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
            
            Image(systemName: "building.2.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
    
    private var signUpForm : some View {
        VStack(spacing: 20) {
            // Club Information Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Club Information")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    CustomTextField(title: "Club Name", text: $clubName, placeholder: "Enter club name")
                    CustomTextField(title: "City", text: $city, placeholder: "Enter city")
                    CustomTextField(title: "Address", text: $address, placeholder: "Enter full address")
                    CustomTextField(title: "Social Link", text: $socialLink, placeholder: "@clubname")
                    CustomTextField(title: "Phone Number", text: $phoneNumber, placeholder: "+1 (555) 123-4567")
                }
                .padding(.horizontal, 20)
            }
            
            // Account Information Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Account Information")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    CustomTextField(title: "Email", text: $email, placeholder: "Enter email address")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    CustomSecureField(title: "Password", text: $password, placeholder: "Enter password")
                    CustomSecureField(title: "Confirm Password", text: $confirmPassword, placeholder: "Confirm password")
                }
                .padding(.horizontal, 20)
            }
            
            // Upload Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Uploads (Optional)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    // Logo Upload
                    Button(action: {
              
                    }) {
                        HStack {
                            Image(systemName: "photo.fill")
                                .font(.title2)
                            Text("Upload Club Logo")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .foregroundColor(.white)
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
                    .padding(.horizontal, 20)
                    
                  
                }
            }
        }
    }
    
    private var submitButton : some View {
        Button(action: {
            // Haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
            navigateToDashboard = true
        }) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                Text("Create Club Account")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.green)
            .cornerRadius(16)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
}

#Preview {
    ClubSignupView()
} 
