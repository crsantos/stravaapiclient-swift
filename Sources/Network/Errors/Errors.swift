//
//  Errors.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 05/03/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

fileprivate enum HeaderConstants {

    static let rateLimitLimitKey = "X-RateLimit-Limit"
    static let rateLimitUsageKey = "X-RateLimit-Usage"
}

fileprivate typealias RateLimitGroup = (limit: RateLimit, usage: RateLimit)

public enum NetworkingError: Error {

    case generic
    case emptyData
    case underlyingError(Error)
    case parsingError(ParseError)
    case apiError(APIHTTPError, APIErrorModel)
}

public enum ParseError: Error {

    case emptyResponse
    case decode(Error) // TODO: try to put it as DecodingError -> catching all of them on Networking
}

public struct RateLimit {

    let shortTerm: Int
    let longTerm: Int
}

public enum APIHTTPError: Error {

    case notFound
    case unauthorized
    case rateLimitingExceeded(RateLimit, RateLimit)
    case forbidden
    case unknown

    static func fromResponse(_ response: HTTPURLResponse) -> APIHTTPError {

        let httpAPIError: APIHTTPError

        switch response.statusCode {

        case 401:

            httpAPIError = .unauthorized

        case 404:

            httpAPIError = .notFound

        case 403:

            if let rateLimitGroup = APIHTTPError.rateLimits(from: response) {

                httpAPIError = .rateLimitingExceeded(
                    rateLimitGroup.limit,
                    rateLimitGroup.usage
                )

            } else {

                httpAPIError = .forbidden
            }

        default:

            httpAPIError = .unknown
        }

        return httpAPIError
    }
}

// MARK: - Private

fileprivate extension APIHTTPError {

    static func rateLimits(from response: HTTPURLResponse) -> RateLimitGroup? {

        if let rateLimitLimit = response.allHeaderFields[HeaderConstants.rateLimitLimitKey] as? String,
            let rateLimitUsage = response.allHeaderFields[HeaderConstants.rateLimitUsageKey] as? String {

            let usageTuple = rateLimitUsage.split(separator: ",")
            let limitTuple = rateLimitLimit.split(separator: ",")

            if limitTuple.count == 2,
                usageTuple.count == limitTuple.count,
                let shortUsage = usageTuple.first,
                let longUsage = usageTuple.last,
                let shortLimit = limitTuple.first,
                let longLimit = limitTuple.last,
                let shortTermUsage = Int(String(describing: shortUsage)),
                let longTermUsage = Int(String(describing: longUsage)),
                let shortTermLimit = Int(String(describing: shortLimit)),
                let longTermLimit = Int(String(describing: longLimit)) {

                return (
                    RateLimit(shortTerm: shortTermLimit, longTerm: longTermLimit),
                    RateLimit(shortTerm: shortTermUsage, longTerm: longTermUsage)
                )
            }
        }

        return nil
    }
}
