//
//  ContentView.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.25)
                    WelcomeTitle()
                    Spacer().frame(height: proxy.size.height * 0.30)
                    Button(action: {
                        // Implement Google Sign In Code
                        viewModel.handleSignInButton()
                    }) {
                        HStack {
                            LoginButton()
                        }
                        // GoogleSignInButton(action: viewModel.handleSignInButton) // Official Google SignIn button with no customization
                    }
                    .navigationDestination(isPresented: $viewModel.isSignedIn) {
                        TripView(viewModel: viewModel.tripsViewModel)
                    }
                    .padding(15)
                    Spacer()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    WelcomeImage()
                        .overlay(Color.black.opacity(0.3))
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.green)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewDevice("iPhone 14 Pro Max")
    }
}

struct WelcomeTitle: View {
    var body: some View {
        Text("Smiles")
            .font(.custom("IM FELL English SC Regular", size: 80))
            .bold()
            .foregroundColor(Color.white)
    }
}

struct LoginButton: View {
    var body: some View {
        HStack {
            Image(systemName: "g.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
            Text("Sign in with Google")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 300, height: 60)
        .background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.8))
        .cornerRadius(15.0)
    }
}

struct WelcomeImage: View {
    var body: some View {
        Image("One")
            .resizable()
            .aspectRatio(
                contentMode: .fill
            )
    }
}
