//
//  SplitsMetric.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct SplitsMetric: Codable {

    let distance: Double
    let elapsedTime: Int
    let elevationDifference: Double
    let movingTime, split: Int
    let averageSpeed: Double
    let paceZone: Int

    enum CodingKeys: String, CodingKey {

        case distance
        case elapsedTime = "elapsed_time"
        case elevationDifference = "elevation_difference"
        case movingTime = "moving_time"
        case split
        case averageSpeed = "average_speed"
        case paceZone = "pace_zone"
    }
}
