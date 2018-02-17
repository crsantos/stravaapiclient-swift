//
//  Lap.swift
//  StravaAPIClient
//
//  Created by Ricardo Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct Lap: Codable {
    let id, resourceState: Int
    let name: String
    let activity, athlete: Athlete
    let elapsedTime, movingTime: Int
    let startDate, startDateLocal: String
    let distance: Double
    let startIndex, endIndex: Int
    let totalElevationGain: Int?
    let averageSpeed, maxSpeed: Double?
    let averageCadence: Double
    let deviceWatts: Bool
    let averageWatts: Double
    let lapIndex, split: Int?
    let segment: Segment?
    let komRank, prRank: JSONNull?
    let hidden: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case name, activity, athlete
        case elapsedTime = "elapsed_time"
        case movingTime = "moving_time"
        case startDate = "start_date"
        case startDateLocal = "start_date_local"
        case distance
        case startIndex = "start_index"
        case endIndex = "end_index"
        case totalElevationGain = "total_elevation_gain"
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case averageCadence = "average_cadence"
        case deviceWatts = "device_watts"
        case averageWatts = "average_watts"
        case lapIndex = "lap_index"
        case split, segment
        case komRank = "kom_rank"
        case prRank = "pr_rank"
        case hidden
    }
}
