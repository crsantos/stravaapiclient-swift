//
//  HighlightedKudoser.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct HighlightedKudoser: Codable {

    let destinationURL: String
    let displayName: String
    let avatarURL: String
    let showName: Bool

    enum CodingKeys: String, CodingKey {

        case destinationURL = "destination_url"
        case displayName = "display_name"
        case avatarURL = "avatar_url"
        case showName = "show_name"
    }
}
