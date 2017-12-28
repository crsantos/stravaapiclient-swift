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

    public init(id: Int, resourceState: Int, firstname: String, lastname: String, profileMedium: String, profile: String, city: String, state: String, country: String, sex: String, friend: JSONNull?, follower: JSONNull?, premium: Bool, createdAt: String, updatedAt: String, followerCount: Int, friendCount: Int, mutualFriendCount: Int, athleteType: Int, datePreference: String, measurementPreference: String, email: String, ftp: Int?, weight: Double, clubs: [Club], bikes: [Bike], shoes: [Bike]) {
        self.id = id
        self.resourceState = resourceState
        self.firstname = firstname
        self.lastname = lastname
        self.profileMedium = profileMedium
        self.profile = profile
        self.city = city
        self.state = state
        self.country = country
        self.sex = sex
        self.friend = friend
        self.follower = follower
        self.premium = premium
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.followerCount = followerCount
        self.friendCount = friendCount
        self.mutualFriendCount = mutualFriendCount
        self.athleteType = athleteType
        self.datePreference = datePreference
        self.measurementPreference = measurementPreference
        self.email = email
        self.ftp = ftp
        self.weight = weight
        self.clubs = clubs
        self.bikes = bikes
        self.shoes = shoes
    }
}

// MARK: Convenience initializers

extension Athlete {

    init?(data: Data) {

        guard let me = try? JSONDecoder().decode(Athlete.self, from: data) else { return nil }
        self.init(id: me.id, resourceState: me.resourceState, firstname: me.firstname, lastname: me.lastname, profileMedium: me.profileMedium, profile: me.profile, city: me.city, state: me.state, country: me.country, sex: me.sex, friend: me.friend, follower: me.follower, premium: me.premium, createdAt: me.createdAt, updatedAt: me.updatedAt, followerCount: me.followerCount, friendCount: me.friendCount, mutualFriendCount: me.mutualFriendCount, athleteType: me.athleteType, datePreference: me.datePreference, measurementPreference: me.measurementPreference, email: me.email, ftp: me.ftp, weight: me.weight, clubs: me.clubs, bikes: me.bikes, shoes: me.shoes)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {

        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(url: String) {

        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {

        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
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
