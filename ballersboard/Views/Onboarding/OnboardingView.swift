//
//  OnboardingView.swift
//  ballersboard
//
//  Created by kingpin on 6/14/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var navigateToHome = false
    @State private var navigateToClubAuth = false
    @State private var animateLogo = false
    @State private var animateText = false
    @State private var animateButtons = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                animatedGradient
                
                floatingParticles
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    appLogoAnimation
                    
                    actionButtons
                    
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animateLogo = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(0.3)) {
                animateText = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(0.6)) {
                animateButtons = true
            }
        }
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
        .navigationDestination(isPresented: $navigateToClubAuth) {
            ClubAuthView()
                .environmentObject(viewModel)
        }
    }
}

extension OnboardingView{
    
    private var animatedGradient: some View{
        LinearGradient(
            gradient: Gradient(colors: [
                Color.black,
                Color.purple.opacity(0.6),
                Color.pink.opacity(0.4),
                Color.black
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(
            .easeInOut(duration: 3)
            .repeatForever(autoreverses: true),
            value: animateLogo)
    }
    
    private var floatingParticles: some View {
        ForEach(0..<20, id: \.self) { index in
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: CGFloat.random(in: 2...6))
                .position(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
                .animation(
                    .easeInOut(duration: Double.random(in: 2...4))
                    .repeatForever(autoreverses: true),
                    value: animateLogo
                )
        }
    }
    
    private var appLogoAnimation: some View {
        VStack(spacing: 40) {
            ZStack {
                // Glowing background circle
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.3),
                                Color.yellow.opacity(0.1),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 20,
                            endRadius: 100
                        )
                    )
                    .frame(width: 200, height: 200)
                    .scaleEffect(animateLogo ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateLogo)
                
                // Main logo
                Image(systemName: "crown.fill")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.yellow, Color.orange]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .yellow.opacity(0.5), radius: 20, x: 0, y: 0)
                    .scaleEffect(animateLogo ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animateLogo)
            }
            .opacity(animateLogo ? 1 : 0)
            .offset(y: animateLogo ? 0 : 50)
            
            // Text Content
            VStack(spacing: 16) {
                Text("Welcome to")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.softWhite)
                    .opacity(animateText ? 1 : 0)
                    .offset(y: animateText ? 0 : 20)
                
                Text("BallersBoard")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.purple.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 0)
                    .opacity(animateText ? 1 : 0)
                    .offset(y: animateText ? 0 : 20)
                
                Text("See who's topping the night")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.softWhite)
                    .multilineTextAlignment(.center)
                    .opacity(animateText ? 1 : 0)
                    .offset(y: animateText ? 0 : 20)
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
    
    private var actionButtons: some View {
        VStack(spacing: 16) {
            
            // Just Browsing Button
            Button(action: {
                navigateToHome = true
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "eye.fill")
                        .font(.title2)
                        .foregroundColor(.black)

                    Text("I'm Just Browsing")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
            }
            .opacity(animateButtons ? 1 : 0)
            .offset(y: animateButtons ? 0 : 30)

            // I Manage a Club Button
            Button(action: {
                navigateToClubAuth = true
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "building.2.fill")
                        .font(.title2)
                        .foregroundColor(.white)

                    Text("I Manage a Club")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                .shadow(color: .purple.opacity(0.4), radius: 15, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            }
            .opacity(animateButtons ? 1 : 0)
            .offset(y: animateButtons ? 0 : 30)
            
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 50)
    }

}

#Preview {
      OnboardingView()
}
