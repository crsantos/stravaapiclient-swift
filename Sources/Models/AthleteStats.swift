//
//  AthleteStats.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 21/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct AthleteStats: Codable {

    let biggestRideDistance: Double
    let biggestClimbElevationGain: Double
    let recentRideTotals: StatsTotals
    let recentRunTotals: StatsTotals
    let recentSwimTotals: StatsTotals
    let ytdRideTotals: StatsTotals
    let ytdRunTotals: StatsTotals
    let ytdSwimTotals: StatsTotals
    let allRideTotals: StatsTotals
    let allRunTotals: StatsTotals
    let allSwimTotals: StatsTotals

    enum CodingKeys: String, CodingKey {

        case biggestRideDistance = "biggest_ride_distance"
        case biggestClimbElevationGain = "biggest_climb_elevation_gain"
        case recentRideTotals = "recent_ride_totals"
        case recentRunTotals = "recent_run_totals"
        case recentSwimTotals = "recent_swim_totals"
        case ytdRideTotals = "ytd_ride_totals"
        case ytdRunTotals = "ytd_run_totals"
        case ytdSwimTotals = "ytd_swim_totals"
        case allRideTotals = "all_ride_totals"
        case allRunTotals = "all_run_totals"
        case allSwimTotals = "all_swim_totals"
    }
}

struct StatsTotals: Codable {

    let count: Int
    let distance: Double
    let movingTime: Int
    let elapsedTime: Int
    let elevationGain: Int
    let achievementCount: Int?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case distance = "distance"
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case elevationGain = "elevation_gain"
        case achievementCount = "achievement_count"
    }
}
