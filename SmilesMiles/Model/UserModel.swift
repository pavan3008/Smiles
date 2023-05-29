//
//  UserModel.swift
//  SmilesMiles
//
//  Created by Pavan Sai Nallagoni on 5/27/23.
//

struct UserInfo: Codable {
    let email: String
    let name: String
    let picture: String
    let sub: String
}

struct MemberInfo: Codable {
    let userId: String
    let userData: MemberData
}

struct MemberData: Codable {
    let email: String
    let username: String
}
