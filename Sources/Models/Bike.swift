//
//  Bike.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public struct Bike: Codable {

    let id: String
    let primary: Bool
    let name: String
    let distance: Double
    let resourceState: Int

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case primary = "primary"
        case name = "name"
        case distance = "distance"
        case resourceState = "resource_state"
    }
}
