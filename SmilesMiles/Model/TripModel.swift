//
//  TripModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 5/27/23.
//

struct Trip: Codable, Equatable {
    let tripID: String
    let tripName: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case tripID = "PK"
        case tripName
        case status
    }
}
