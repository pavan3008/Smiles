//
//  TripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI
import Foundation
import Alamofire

struct User: Decodable {
    let name: String
    let email: String
}

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
            print("Error: Trip name already exists.")
        } else {
            trips.append(tripName)
            numberOfTrips += 1
        }
    }
    
    @Published var user: User?
    
    func getUserDetails() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found in UserDefaults")
            return
        }
        
        let url = "https://www.googleapis.com/oauth2/v3/userinfo"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}
