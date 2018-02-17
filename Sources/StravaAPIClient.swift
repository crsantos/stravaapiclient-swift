//
//  StravaAPIClient.swift
//  stravaswiftapiclient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public struct StravaConfig: AuthenticatableConfig {

    let clientId: String
    let clientSecret: String
    let redirectURL: String
    public let accessToken: String
}

public class StravaAPIClient {

    let config: StravaConfig
    let networking: Networking

    init(with config: StravaConfig) {

        self.config = config
        self.networking = Networking(with: config, requestSerializerType: RequestSerializer.self)
    }

    func requestCurrentAthlete(with completion: @escaping APICompletion<Athlete>) {

        self.networking.request(with: StravaAPIRouter.getCurrentAthlete, completion: completion)
    }

    func requestCurrentAthleteActivities(with completion: @escaping APICompletion<[SummaryActivity]>) {

        self.networking.request(with: StravaAPIRouter.getCurrentAthleteActivities, completion: completion)
    }
}
