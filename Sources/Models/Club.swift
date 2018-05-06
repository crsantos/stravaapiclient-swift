//
//  Club.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public struct Club: Codable {

    let id: Int
    let resourceState: Int
    let name: String
    let profileMedium: String
    let profile: String
    let coverPhoto: String?
    let coverPhotoSmall: String?
    let sportType: String
    let city: String?
    let state: String?
    let country: String
    let purplePrivate: Bool
    let memberCount: Int
    let featured: Bool
    let verified: Bool
    let url: String

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case resourceState = "resource_state"
        case name = "name"
        case profileMedium = "profile_medium"
        case profile = "profile"
        case coverPhoto = "cover_photo"
        case coverPhotoSmall = "cover_photo_small"
        case sportType = "sport_type"
        case city = "city"
        case state = "state"
        case country = "country"
        case purplePrivate = "private"
        case memberCount = "member_count"
        case featured = "featured"
        case verified = "verified"
        case url = "url"
    }
}
