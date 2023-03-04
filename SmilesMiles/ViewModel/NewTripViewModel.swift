//
//  NewTripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class NewTripViewModel: ObservableObject {
    @Binding var trips: [String]
    @Binding var isPresented: Bool
    @Published var name = ""
    @Binding var numberOfTrips: Int

    init(trips: Binding<[String]>, isPresented: Binding<Bool>, numberOfTrips: Binding<Int>) {
        self._trips = trips
        self._isPresented = isPresented
        self._numberOfTrips = numberOfTrips
    }

    func saveTrip() {
        trips.append(name)
        numberOfTrips += 1
        isPresented = false
        reset()
    }

    func reset() {
        name = ""
    }
}
