//
//  MainViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var isActive = false

    func signInWithGoogle() {
        // Implement Google Sign In Code
        isActive = true
    }
}
