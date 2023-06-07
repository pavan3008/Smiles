//
//  TripDetailViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class TripDetailViewModel: ObservableObject {
    @Published var trips: [Trip]
    @Published var numberOfTrips: Int
    
    let trip: Trip
    
    init(trips: [Trip], numberOfTrips: Int, trip: Trip) {
        self.trips = trips
        self.numberOfTrips = numberOfTrips
        self.trip = trip
    }
    
    func deleteTrip() {
        guard let index = trips.firstIndex(of: trip) else {
            return
        }
        trips.remove(at: index)
        numberOfTrips -= 1
    }
}
