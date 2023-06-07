//
//  TripViewModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 2/27/23.
//

import SwiftUI
import Alamofire

class TripViewModel: ObservableObject {
    @Published var user: UserInfo?
    @Published var trips: [Trip] = []
    @Published var users: [MemberInfo] = []
    @Published var searchText = ""
    @Published var numberOfTrips = 0

    func filteredTrips() -> [Trip] {
        if searchText.isEmpty {
            return trips
        } else {
            return trips.filter { $0.tripName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
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
            .responseDecodable(of: UserInfo.self) { response in
                switch response.result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.user = user
                        print("User details fetched successfully:")
                        print("Name: \(user.name)")
                        print("Email: \(user.email)")
                        print("Sub: \(user.sub)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    
    func fetchTrips(for userId: String) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found in UserDefaults")
            return
        }
        
        guard let encodedUserId = userId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            print("Error: Failed to encode the userId")
            return
        }
        
        print("UserId:\(encodedUserId)")
        
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/users/\(encodedUserId)/trips"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: [Trip].self) { response in
                switch response.result {
                case .success(let trips):
                    DispatchQueue.main.async {
                        self.trips = trips
                        self.numberOfTrips = trips.count
                        print("Fetched trips: \(trips)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data {
                        let errorResponse = String(data: data, encoding: .utf8)
                        print("Error Response: \(errorResponse ?? "")")
                    }
                }
            }
    }
    
    func modifyTrip(tripId: String, tripName: String?, tripStatus: String?, completion: @escaping (Result<[Trip]?, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found in UserDefaults")
            return
        }
        
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/trips/\(tripId)"
        
        var parameters: [String: Any] = [:]
        if let name = tripName {
            parameters["trip_name"] = name
        }
        if let status = tripStatus {
            parameters["trip_status"] = status
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: [Trip].self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let updatedTrips):
                    DispatchQueue.main.async {
                        self.trips = updatedTrips
                        self.numberOfTrips = updatedTrips.count
                        completion(.success(updatedTrips))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteTrip(tripId: String) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found in UserDefaults")
            return
        }
        
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/trips/\(tripId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .delete, headers: headers)
            .validate()
            .response { response in
                if let data = response.data {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
    }
    
    func getUsersForTrip(tripId: String) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found in UserDefaults")
            return
        }
        
        let url = "https://c0clbl0v9h.execute-api.us-west-2.amazonaws.com/prod/trips/\(tripId)/users"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: [MemberInfo].self) { response in
                switch response.result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    print("Error fetching users: \(error)")
                }
            }
    }
}
