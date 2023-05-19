//
//  MainViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Alamofire

class MainViewModel: ObservableObject {
    @Published var isSignedIn = false
    let tripsViewModel: TripViewModel
    
    init() {
        self.tripsViewModel = TripViewModel()
    }
    
    func handleSignInButton() {
        let config = GIDConfiguration(clientID: Secrets.clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] signInResult, error in
            guard let self = self, let result = signInResult else {
                // Inspect error
                return
            }
            
            result.user.refreshTokensIfNeeded { [weak self] user, error in
                guard error == nil else { return }
                print("sending token to signin")
                // Send ID token to backend.
                let idToken = result.user.idToken?.tokenString
                self?.tokenSignIn(idToken: idToken!)
            }
            // If sign in succeeded, display the app's main content View.
            if let user = signInResult?.user {
                let name = user.profile?.name ?? "Unknown"
                let email = user.profile?.email ?? "Unknown"
                print("Welcome, \(name)! Your email is \(email).")
                let idToken = result.user.idToken?.tokenString
                print("ID Token: \(String(describing: idToken))")
                self.isSignedIn = true
                print("success sign in")
                if let accessToken = GIDSignIn.sharedInstance.currentUser?.accessToken {
                    // Convert the GIDToken object to a string
                    let accessTokenString = accessToken.tokenString
                    print("access Token: \(String(describing: accessTokenString))")
                    // Save the access token string to UserDefaults
                    UserDefaults.standard.set(accessTokenString, forKey: "accessToken")
                }
                print("saved user")
            } else {
                print("Sign in failed.")
            }
        }
    }
    
    struct TokenVerifyResponse: Codable {
        let message: String
        let userInfo: UserInfo
    }
    
    struct UserInfo: Codable {
        let email: String
        let name: String
        let picture: String
        let sub: String
    }
    
    func tokenSignIn(idToken: String) {
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/verifyToken"
        
        let parameters: [String: Any] = ["idToken": idToken]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let responseObject = try JSONDecoder().decode(TokenVerifyResponse.self, from: data)
                        let userInfo = responseObject.userInfo
                        print(userInfo)
                        print("Token verification message: \(responseObject.message)")
                        print("User email: \(userInfo.email)")
                        print("User name: \(userInfo.name)")
                        print("User picture: \(userInfo.picture)")
                        print("User sub: \(userInfo.sub)")
                    } catch {
                        print("Error decoding response: \(error)")
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                }
            }
    }
}
