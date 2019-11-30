//
//  StravaAPIClient.swift
//  stravaswiftapiclient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

typealias StravaAPICompletion<T: Codable> = APICompletion<T, StravaAPIError>
typealias AthleteCompletion = StravaAPICompletion<Athlete>
typealias SummaryActivitiesCompletion = StravaAPICompletion<[SummaryActivity]>
typealias AthleteStatsCompletion = StravaAPICompletion<AthleteStats>
typealias ClubListCompletion = StravaAPICompletion<[Club]>
typealias SummaryActivityCompletion = StravaAPICompletion<SummaryActivity>

public struct StravaConfig: AuthenticatableConfig {

    let clientId: String
    let clientSecret: String
    let redirectURL: String
    public let accessToken: String
}

public class StravaAPIClient {

    let config: StravaConfig
    let networking: CRNetworking

    init(with config: StravaConfig) {

        self.config = config
        self.networking = CRNetworking(with: config, requestSerializerType: RequestSerializer.self)
    }

    func requestCurrentAthlete(with completion: @escaping AthleteCompletion) {

        self.networking.request(with: StravaAPIRouter.getCurrentAthlete, completion: completion)
    }

    func requestCurrentAthleteActivities(with completion: @escaping SummaryActivitiesCompletion) {

        self.networking.request(with: StravaAPIRouter.getCurrentAthleteActivities, completion: completion)
    }

    func requestCurrentAthleteStats(athleteId: Int, completion: @escaping AthleteStatsCompletion) {

        self.networking.request(with: StravaAPIRouter.getAthleteStats(athleteId), completion: completion)
    }

    func requestCurrentAthleteClubs(with completion: @escaping ClubListCompletion) {

        self.networking.request(with: StravaAPIRouter.getCurrentAthleteClubs, completion: completion)
    }

    func requestActivity(activityId: Int, completion: @escaping SummaryActivityCompletion) {

        self.networking.request(with: StravaAPIRouter.getActivity(activityId), completion: completion)
    }
}
