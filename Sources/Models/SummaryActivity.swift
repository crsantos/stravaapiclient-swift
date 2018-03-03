//
//  SummaryActivity.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let activity = try SummaryActivity(json)

enum WorkoutType: Int, Codable {

    case defaultRun = 0
    case raceRun = 1
    case longRun = 2
    case workoutRun = 3
    case defaultRide = 10
    case raceRide = 11
    case workoutRide = 12
}

enum ActivityType: String, Codable {

    case alpineSki = "AlpineSki"
    case backcountrySki = "BackcountrySki"
    case canoeing = "Canoeing"
    case crossfit = "Crossfit"
    case eBikeRide = "EBikeRide"
    case elliptical = "Elliptical"
    case hike = "Hike"
    case iceSkate = "IceSkate"
    case inlineSkate = "InlineSkate"
    case kayaking = "Kayaking"
    case kitesurf = "Kitesurf"
    case nordicSki = "NordicSki"
    case ride = "Ride"
    case rockClimbing = "RockClimbing"
    case rollerSki = "RollerSki"
    case rowing = "Rowing"
    case run = "Run"
    case snowboard = "Snowboard"
    case snowshoe = "Snowshoe"
    case stairStepper = "StairStepper"
    case standUpPaddling = "StandUpPaddling"
    case surfing = "Surfing"
    case swim = "Swim"
    case virtualRide = "VirtualRide"
    case walk = "Walk"
    case weightTraining = "WeightTraining"
    case windsurf = "Windsurf"
    case workout = "Workout"
    case yoga = "Yoga"
    case unknown
}

struct SummaryActivity: Codable {

    let id, resourceState: Int
    let externalID: String
    let uploadID: Int
    let athlete: AthleteId
    let name: String
    let distance: Double
    let movingTime: Int
    let elapsedTime: Int
    let totalElevationGain: Int
    let type: String
    let startDate: String
    let startDateLocal: String
    let timezone: String
    let utcOffset: Int
    let startLatlng, endLatlng: [Double]?
    let locationCity, locationState: JSONNull?
    let locationCountry: String
    let startLatitude, startLongitude: Double?
    let achievementCount: Int
    let kudosCount: Int
    let commentCount: Int
    let athleteCount: Int
    let photoCount: Int
    let map: Map?
    let trainer: Bool
    let commute: Bool
    let manual: Bool
    let activityPrivate: Bool
    let flagged: Bool
    let gearID: String?
    let fromAcceptedTag: Bool
    let averageSpeed, maxSpeed: Double
    let averageCadence: Double?
    let averageTemp: Int
    let averageWatts: Double?
    let weightedAverageWatts: Int?
    let kilojoules: Double?
    let deviceWatts: Bool?
    let hasHeartrate: Bool
    let maxWatts: Int?
    let elevHigh, elevLow: Double
    let prCount, totalPhotoCount: Int
    let hasKudoed: Bool
    let workoutType: WorkoutType?
    let sufferScore: JSONNull?
    let description: String?
    let calories: Double?
    let segmentEfforts: [Lap]?
    let splitsMetric: [SplitsMetric]?
    let laps: [Lap]?
    let gear: Gear?
    let partnerBrandTag: JSONNull?
    let photos: Photo?
    let highlightedKudosers: [HighlightedKudoser]?
    let deviceName: String?
    let embedToken: String?
    let segmentLeaderboardOptOut: Bool?
    let leaderboardOptOut: Bool?

    enum CodingKeys: String, CodingKey {

        case id
        case resourceState = "resource_state"
        case externalID = "external_id"
        case uploadID = "upload_id"
        case athlete, name, distance
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case totalElevationGain = "total_elevation_gain"
        case type
        case startDate = "start_date"
        case startDateLocal = "start_date_local"
        case timezone
        case utcOffset = "utc_offset"
        case startLatlng = "start_latlng"
        case endLatlng = "end_latlng"
        case locationCity = "location_city"
        case locationState = "location_state"
        case locationCountry = "location_country"
        case startLatitude = "start_latitude"
        case startLongitude = "start_longitude"
        case achievementCount = "achievement_count"
        case kudosCount = "kudos_count"
        case commentCount = "comment_count"
        case athleteCount = "athlete_count"
        case photoCount = "photo_count"
        case map
        case trainer
        case commute
        case manual
        case activityPrivate = "private"
        case flagged
        case gearID = "gear_id"
        case fromAcceptedTag = "from_accepted_tag"
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case averageCadence = "average_cadence"
        case averageTemp = "average_temp"
        case averageWatts = "average_watts"
        case weightedAverageWatts = "weighted_average_watts"
        case kilojoules
        case deviceWatts = "device_watts"
        case hasHeartrate = "has_heartrate"
        case maxWatts = "max_watts"
        case elevHigh = "elev_high"
        case elevLow = "elev_low"
        case prCount = "pr_count"
        case totalPhotoCount = "total_photo_count"
        case hasKudoed = "has_kudoed"
        case workoutType = "workout_type"
        case sufferScore = "suffer_score"
        case description, calories
        case segmentEfforts = "segment_efforts"
        case splitsMetric = "splits_metric"
        case laps, gear
        case partnerBrandTag = "partner_brand_tag"
        case photos
        case highlightedKudosers = "highlighted_kudosers"
        case deviceName = "device_name"
        case embedToken = "embed_token"
        case segmentLeaderboardOptOut = "segment_leaderboard_opt_out"
        case leaderboardOptOut = "leaderboard_opt_out"
    }
}
