//
//  Athlete.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

// Generated with https://app.quicktype.io/#l=swift

public struct Athlete: Codable {

    let id: Int
    let resourceState: Int
    let firstname: String
    let lastname: String
    let profileMedium: String
    let profile: String
    let city: String
    let state: String
    let country: String
    let sex: String
    let friend: JSONNull?
    let follower: JSONNull?
    let premium: Bool
    let createdAt: String
    let updatedAt: String
    let followerCount: Int
    let friendCount: Int
    let mutualFriendCount: Int
    let athleteType: Int
    let datePreference: String
    let measurementPreference: String
    let email: String
    let ftp: Int?
    let weight: Double
    let clubs: [Club]
    let bikes: [Bike]
    let shoes: [Bike]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case resourceState = "resource_state"
        case firstname = "firstname"
        case lastname = "lastname"
        case profileMedium = "profile_medium"
        case profile = "profile"
        case city = "city"
        case state = "state"
        case country = "country"
        case sex = "sex"
        case friend = "friend"
        case follower = "follower"
        case premium = "premium"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case followerCount = "follower_count"
        case friendCount = "friend_count"
        case mutualFriendCount = "mutual_friend_count"
        case athleteType = "athlete_type"
        case datePreference = "date_preference"
        case measurementPreference = "measurement_preference"
        case email = "email"
        case ftp = "ftp"
        case weight = "weight"
        case clubs = "clubs"
        case bikes = "bikes"
        case shoes = "shoes"
    }
}

struct AthleteId: Codable {
    let id, resourceState: Int

    enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
    }
}

// MARK: Encode/decode helpers

public class JSONNull: Codable {

    public init() {}

    public required init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
