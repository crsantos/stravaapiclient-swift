//
//  StravaErrors.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/08/2019.
//  Copyright © 2019 crsantos.info. All rights reserved.
//

import Foundation

private enum HeaderConstants {

    static let rateLimitLimitKey = "X-RateLimit-Limit"
    static let rateLimitUsageKey = "X-RateLimit-Usage"
}

private typealias RateLimitGroup = (limit: RateLimit, usage: RateLimit)

public struct RateLimit {

    let shortTerm: Int
    let longTerm: Int
}

public struct StravaAPIError: APIError {

    public let errorModel: StravaAPIErrorModel?
    public let errorType: APIErrorType

    private let response: HTTPURLResponse

    public init(response: HTTPURLResponse, data: Data) throws {

        self.errorType = APIErrorType(response)
        self.response = response
        self.errorModel = try type(of: self).parse(data)
    }
}

public extension StravaAPIError {

    enum APIErrorType {
        case notFound
        case unauthorized
        case rateLimitingExceeded(RateLimit, RateLimit)
        case forbidden
        case serverError
        case unknown

        public init(_ response: HTTPURLResponse) {

            switch response.statusCode {

            case 401: self = .unauthorized

            case 404: self = .notFound

            case 403:
                if let rateLimitGroup = response.rateLimits {
                    self = .rateLimitingExceeded(
                        rateLimitGroup.limit,
                        rateLimitGroup.usage
                    )
                } else {
                    self = .forbidden
                }

            case (500...599): self = .serverError

            default:
                self = .unknown
            }
        }
    }
}

// MARK: - Private

private extension StravaAPIError {

    static func parse<T: Codable>(_ data: Data) throws -> T {

        return try JSONDecoder().decode(T.self, from: data)
    }
}

private extension HTTPURLResponse {

    var rateLimits: RateLimitGroup? {

        if let rateLimitLimit = self.allHeaderFields[HeaderConstants.rateLimitLimitKey] as? String,
            let rateLimitUsage = self.allHeaderFields[HeaderConstants.rateLimitUsageKey] as? String {

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
