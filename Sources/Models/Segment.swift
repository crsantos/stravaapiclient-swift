//
//  Segment.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct Segment: Codable {

    let id, resourceState: Int
    let name: String
    let activityType: ActivityType
    let distance, averageGrade, maximumGrade, elevationHigh: Double
    let elevationLow: Double
    let startLatlng, endLatlng: [Double]
    let startLatitude, startLongitude, endLatitude, endLongitude: Double
    let climbCategory: Int
    let city, state, country: String
    let segmentPrivate, hazardous, starred: Bool

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
        case city, state, country
        case segmentPrivate = "private"
        case hazardous, starred
    }
}
