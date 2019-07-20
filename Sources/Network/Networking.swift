//
//  Networking.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public protocol AuthenticatableConfig {

    var accessToken: String { get }
}

public enum Result<T, E> {

    case success(T)
    case failure(E)
}

public typealias APICompletion<T: Codable> = (Result<T, NetworkingError>) -> ()

struct Networking {

    private let requester: HTTPRequester = HTTPRequester()
    private let requestSerializer: RequestSerializable

    init(with config: AuthenticatableConfig, requestSerializerType: RequestSerializable.Type) {

        self.requestSerializer = requestSerializerType.init(with: config)
    }

    func request<T: Codable>(with resourceRequest: URLResourceRequestConvertible, completion: @escaping APICompletion<T>) {

        let request = self.requestSerializer.serializeResource(resourceRequest)

        self.requester.request(with: request) { data, response, error in

            self.handleDataTaskResponse(data: data, response: response, error: error, completion: completion)
        }
    }
}

// MARK: - Private

private extension Networking {

    func handleDataTaskResponse<T: Codable>(data: Data?, response: URLResponse?, error: Error?, completion: APICompletion<T>) {

        // 1. Check if there is an error, if so, fail immediately
        if let error = error as NSError? {

            completion(.failure(.underlyingError(error)))
            return
        }

        // 2. check if response is HTTPURLResponse, otherwise we cannot use it, fail right there
        guard let response = response as? HTTPURLResponse else {

            completion(.failure(.generic))
            return
        }

        // 2.1 - check if data exists
        guard case let .data(data) = data.unwrapped else {

            completion(.failure(.emptyData))
            return
        }

        // 2.2 check status code
        if response.hasAcceptableStatusCode == false {

            self.handleErrorData(data, response: response, completion: completion)

        } else {

            self.parse(data, completion: completion)
        }
    }

    func handleErrorData<T: Codable>(_ data: Data, response: HTTPURLResponse, completion: APICompletion<T>) {

        self.parseError(data) { result in

            if case let .success(apiErrorModel) = result {

                let httpAPIError = APIHTTPError.fromResponse(response)
                completion(.failure(.apiError(httpAPIError, apiErrorModel)))
            }
        }
    }

    func parse<T: Codable>(_ data: Data, completion: APICompletion<T>) {

        do {

            let object = try JSONDecoder().decode(T.self, from: data)
            completion(.success(object))

        } catch let error {

            completion(.failure(.parsingError(.decode(error))))
        }
    }

    func parseError(_ data: Data, completion: APICompletion<APIErrorModel>) {

        self.parse(data, completion: completion)
    }
}
