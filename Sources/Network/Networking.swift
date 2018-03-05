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

    fileprivate let requester: HTTPRequester = HTTPRequester()
    fileprivate let requestSerializer: RequestSerializable

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

fileprivate extension Networking {

    func handleDataTaskResponse<T: Codable>(data: Data?, response: URLResponse?, error: Error?, completion: APICompletion<T>) {

        if let response = response as? HTTPURLResponse,
            response.hasAcceptableStatusCode == false,
            let data = data,
            data.isEmpty == false {

            self.handleErrorData(data, response: response, completion: completion)
            return
        }

        if let error = error as NSError? {

            completion(.failure(.underlyingError(error)))

        } else if let data = data {

            // if case let .data(existingData) = data.unwrapped
            guard data.isEmpty == false else { // TODO: create a result based unwrap of data?! .existingData(Data) / .emptyData -> ?

                completion(.failure(.emptyData))
                return
            }

            self.parse(data, completion: completion)

        } else {

            completion(.failure(.generic))
        }
    }

    func handleErrorData<T: Codable>(_ data: Data, response: HTTPURLResponse, completion: APICompletion<T>) {

        self.parseError(data, completion: { result in

            if case let .success(apiErrorModel) = result {

                let httpAPIError = APIHTTPError.fromResponse(response)
                completion(.failure(.apiError(httpAPIError, apiErrorModel)))
            }
        })
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
