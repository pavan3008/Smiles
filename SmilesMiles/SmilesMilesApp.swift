//
//  SmilesMilesApp.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/8/23.
//

import SwiftUI
import GoogleSignIn

@main
struct SmilesMilesApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onOpenURL { url in
                              GIDSignIn.sharedInstance.handle(url)
                            }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let user = user {
                            // User exists, perform further actions
                            print("Previous sign-in restored for user: \(user)")
                        } else if let error = error {
                            // Handle error
                            print("Error restoring previous sign-in: \(error.localizedDescription)")
                        }
                    }
                }
        }
    }
}
