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
                    // Check if `user` exists; otherwise, do something with `error`
                  }
                }
        }
    }
}
