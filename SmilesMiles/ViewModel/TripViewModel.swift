//
//  TripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI

class TripViewModel: ObservableObject {
    @Published var trips: [String] = []
    @Published var searchText = ""
    @Published var numberOfTrips = 0
    
    func filteredTrips() -> [String] {
        if searchText.isEmpty {
            return trips
        } else {
            return trips.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func deleteTrip(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
    }
    
    func addTrip(_ tripName: String) {
        if trips.contains(tripName) {
            // trip name already exists, show error message or handle accordingly
            print("Error: Trip name already exists.")
        } else {
            trips.append(tripName)
            numberOfTrips += 1
        }
    }
}
