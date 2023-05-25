//
//  NewTripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class NewTripViewModel: ObservableObject {
    @Published var name = ""
    @Published var errorMessage = ""
    @Published var isDuplicateTripName = false
    @Published var trips: [String]

    let onSave: (String) -> Void
    let onCancel: () -> Void

    init(trips: [String], onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self.trips = trips
        self.onSave = onSave
        self.onCancel = onCancel
    }

    func saveTrip() {
        if trips.contains(name) {
            isDuplicateTripName = true
        } else {
            onSave(name)
        }
    }

    func cancel() {
        onCancel()
    }
}
