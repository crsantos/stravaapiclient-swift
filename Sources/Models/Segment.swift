//
//  Segment.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct SegmentEffort: Codable {

    let id, resourceState: Int
    let name: String
    let activity: MetaActivity
    let athlete: MetaAthlete
    let elapsedTime, movingTime: Int
    let startDate, startDateLocal: String
    let distance: Double
    let startIndex, endIndex: Int
    let averageCadence: Double
    let deviceWatts: Bool
    let averageWatts: Double
    let segment: Segment
    let komRank, prRank: JSONNull?
    let hidden: Bool

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
        case averageCadence = "average_cadence"
        case deviceWatts = "device_watts"
        case averageWatts = "average_watts"
        case segment
        case komRank = "kom_rank"
        case prRank = "pr_rank"
        case hidden
    }
}

struct Segment: Codable {

    let id, resourceState: Int
    let name: String
    let activityType: ActivityType
    let distance: Double
    let averageGrade: Double
    let maximumGrade: Double
    let elevationHigh: Double
    let elevationLow: Double
    let startLatlng: [Double]
    let endLatlng: [Double]
    let startLatitude: Double
    let startLongitude: Double
    let endLatitude: Double
    let endLongitude: Double
    let climbCategory: Int
    let city, state, country: String
    let segmentPrivate: Bool
    let hazardous: Bool
    let starred: Bool

    enum CodingKeys: String, CodingKey {

        case id
        case resourceState = "resource_state"
        case name
        case activityType = "activity_type"
        case distance
        case averageGrade = "average_grade"
        case maximumGrade = "maximum_grade"
        case elevationHigh = "elevation_high"
        case elevationLow = "elevation_low"
        case startLatlng = "start_latlng"
        case endLatlng = "end_latlng"
        case startLatitude = "start_latitude"
        case startLongitude = "start_longitude"
        case endLatitude = "end_latitude"
        case endLongitude = "end_longitude"
        case climbCategory = "climb_category"
        case city
        case state
        case country
        case segmentPrivate = "private"
        case hazardous, starred
    }
}
