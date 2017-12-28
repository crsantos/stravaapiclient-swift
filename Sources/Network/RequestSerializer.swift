//
//  RequestSerializer.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

struct RequestSerializer {

    fileprivate enum Constants {

        static let bearerKey = "Bearer"
        static let authorizationKey = "Authorization"
    }

    let config: AuthenticatableConfig
}

extension RequestSerializer: RequestSerializable {

    init(with config: AuthenticatableConfig) {

        self.config = config
    }

    func serializeResource(_ resourceRequestConvertible: URLResourceRequestConvertible) -> URLRequest {

        var request = resourceRequestConvertible.asURLRequest
        request.setValue("\(Constants.bearerKey) \(config.accessToken)", forHTTPHeaderField: Constants.authorizationKey)
        return request
    }
}
