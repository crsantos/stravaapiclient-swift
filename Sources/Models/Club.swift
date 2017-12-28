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
        case url = "url"
    }

    public init(id: Int, resourceState: Int, name: String, profileMedium: String, profile: String, coverPhoto: String?, coverPhotoSmall: String?, sportType: String, city: String?, state: String?, country: String, purplePrivate: Bool, memberCount: Int, featured: Bool, url: String) {

        self.id = id
        self.resourceState = resourceState
        self.name = name
        self.profileMedium = profileMedium
        self.profile = profile
        self.coverPhoto = coverPhoto
        self.coverPhotoSmall = coverPhotoSmall
        self.sportType = sportType
        self.city = city
        self.state = state
        self.country = country
        self.purplePrivate = purplePrivate
        self.memberCount = memberCount
        self.featured = featured
        self.url = url
    }
}

extension Club {

    init?(data: Data) {

        guard let me = try? JSONDecoder().decode(Club.self, from: data) else { return nil }
        self.init(id: me.id, resourceState: me.resourceState, name: me.name, profileMedium: me.profileMedium, profile: me.profile, coverPhoto: me.coverPhoto, coverPhotoSmall: me.coverPhotoSmall, sportType: me.sportType, city: me.city, state: me.state, country: me.country, purplePrivate: me.purplePrivate, memberCount: me.memberCount, featured: me.featured, url: me.url)
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
