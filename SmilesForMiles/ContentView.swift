//
//  ContentView.swift
//  SmilesForMiles
//
//  Created by Pavan Sai Nallagoni on 7/5/22.
//

import SwiftUI


let sampleUsername = "Username"
let samplePassword = "Password"
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView : View {
    @State var username: String = ""
    @State var password: String = ""
    @State var loginFail: Bool = false
    @State var loginSuccess: Bool = false
    
    var body: some View {
        VStack {
            WelcomeTitle()
            WelcomeImage()
            Username(username: $username)
            Password(password: $password)
            if loginFail {
                Text("Incorrect Credentials")
                    .offset(y: -10)
                    .foregroundColor(Color(hue: 0.995, saturation: 0.951, brightness: 0.772))
            }
            
            if loginSuccess{
                Text("Login Success!")
            }
            Button(action: {
                if self.username == sampleUsername && self.password == samplePassword {
                    self.loginSuccess = true
                    self.loginFail = false
                } else{
                    self.loginFail = true
//                    Below: Not need once its successful
//                    self.loginSuccess = false
                }
            }) {
                LoginButton()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeTitle: View {
    var body: some View {
        Text("Smiles For Miles")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color(red: 1.0, green: 0.2, blue: 0.3, opacity: 1.0))
            .padding(.bottom, 20)
            .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
    }
}


struct WelcomeImage: View {
    var body: some View {
        Image("travel")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

// Username
struct Username: View {
    @Binding var username: String
    var body: some View {
        return TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

// Password
struct Password: View {
    @Binding var password: String
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

// Login Button
struct LoginButton: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color(red: 1.0, green: 0.2, blue: 0.3, opacity: 1.0))
            .cornerRadius(15.0)
    }
}
