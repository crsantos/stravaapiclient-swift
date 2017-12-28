//
//  StravaAPIClient.swift
//  stravaswiftapiclient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

// TODO:
// ~ 1- obtain access token from: https://www.strava.com/oauth/authorize?client_id=9&response_type=code&redirect_uri=http://localhost/token_exchange.php&approval_prompt=force
// ~ 2- configure POSTMan with access Token
// ~ 3- network layer - request<T> completion: Result<T,Error>
// 3.1- network config init with creds
// ~ 4- Router
// ~ 5- request with generic methods
// 6 - Inject headers

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
}
