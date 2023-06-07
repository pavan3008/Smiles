//
//  TripModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 5/27/23.
//

struct Trip: Codable, Equatable {
    let tripId: String
    var tripName: String
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case tripId = "PK"
        case tripName
        case status
    }
}
