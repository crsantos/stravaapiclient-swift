//
//  Gear.swift
//  StravaAPIClient
//
//  Created by Ricardo Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct Gear: Codable {
    let id: String
    let primary: Bool
    let name: String
    let resourceState, distance: Int

    enum CodingKeys: String, CodingKey {
        case id, primary, name
        case resourceState = "resource_state"
        case distance
    }
}
