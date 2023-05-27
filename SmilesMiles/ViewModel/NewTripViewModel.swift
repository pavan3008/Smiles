//
//  NewTripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI
import Alamofire

class NewTripViewModel: ObservableObject {
    @Published var name = ""
    @Published var errorMessage = ""
    @Published var isDuplicateTripName = false
    @Published var isTripSaved = false
    let trips: TripViewModel

    let onSave: (String) -> Void
    let onCancel: () -> Void

    init(trips: TripViewModel, onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self.trips = trips
        self.onSave = onSave
        self.onCancel = onCancel
    }

    func saveTrip() {
            if trips.trips.contains(where: { $0.tripName == name }) {
                isDuplicateTripName = true
            } else {
                createTripForUser(userId: trips.user!.sub, tripName: name) { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
//                            let newTrip = Trip(tripID: trip.tripID, tripName: trip.tripName, status: trip.status)
//                            self.trips.addTrip(newTrip)
                            self.isTripSaved = true
                            self.onSave("Trip created successfully")
                        }

                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.errorMessage = error.localizedDescription
                        }
                    }
                }
            }
        }

    func cancel() {
        onCancel()
    }

    private func createTripForUser(userId: String, tripName: String, completion: @escaping (Result<Trip, Error>) -> Void) {
        guard let encodedUserId = userId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            print("Error: Failed to encode the userId")
            return
        }
        
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/users/\(encodedUserId)/trips"
        
        let parameters: [String: Any] = [
            "trip_name": tripName
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Trip.self) { response in
                switch response.result {
                case .success(let trip):
                    completion(.success(trip))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
