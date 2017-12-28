//
//  StravaAPIRouter.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

enum StravaAPIRouter {

    fileprivate enum Constants {

        static let baseURL = "https://www.strava.com/api"
        static let apiVersion = "v3"
    }

    case getCurrentAthlete
}

// MARK: - URLResourceRequestConvertible

extension StravaAPIRouter: URLResourceRequestConvertible {

    var asURLRequest: URLRequest {

        var baseURL = URL(string: Constants.baseURL)!
        baseURL.appendPathComponent(Constants.apiVersion)
        baseURL.appendPathComponent(self.resourcePath)

        var request = URLRequest(url: baseURL)
        request.httpMethod = self.HTTPMethod.rawValue
        request.timeoutInterval = self.timeout

        return request
    }
}

// MARK: - Private

fileprivate extension StravaAPIRouter {

    var resourcePath: String {

        switch self {

        case .getCurrentAthlete:

            return "athlete"
        }
    }

    var timeout: TimeInterval {

        return 2.0
    }

    var HTTPMethod: HTTPMethod {

        switch self {

        case .getCurrentAthlete:

            return .get
        }
    }
}
