//
//  TripDetailViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class TripDetailViewModel: ObservableObject {
    @Published var trips: [String]
    @Published var numberOfTrips: Int
    
    let tripName: String
    
    init(trips: [String], numberOfTrips: Int, tripName: String) {
        self.trips = trips
        self.numberOfTrips = numberOfTrips
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
