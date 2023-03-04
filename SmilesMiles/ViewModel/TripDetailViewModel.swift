//
//  TripDetailViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class TripDetailViewModel: ObservableObject {
    @Binding var trips: [String]
    @Binding var numberOfTrips: Int
    let tripName: String

    init(trips: Binding<[String]>, numberOfTrips: Binding<Int>, tripName: String) {
        self._trips = trips
        self._numberOfTrips = numberOfTrips
        self.tripName = tripName
    }

    func deleteTrip() {
        guard let index = trips.firstIndex(of: tripName) else {
            return
        }
        trips.remove(at: index)
        numberOfTrips -= 1
    }
}
