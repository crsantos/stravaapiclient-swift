//
//  Map.swift
//  StravaAPIClient
//
//  Created by Ricardo Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct Map: Codable {

    let id: String
    let polyline: String?
    let resourceState: Int
    let summaryPolyline: String?

    enum CodingKeys: String, CodingKey {

        case id, polyline
        case resourceState = "resource_state"
        case summaryPolyline = "summary_polyline"
    }
}
