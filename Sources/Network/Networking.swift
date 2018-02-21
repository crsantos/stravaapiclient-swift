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

public enum NetworkingError: Error {

    case generic
    case emptyData
    case underlyingErrorResponse(Error, URLResponse)
    case underlyingError(Error)
    case parsingError(ParseError)
}

public enum ParseError: Error {

    case emptyResponse
    case decode(Error)
}

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

        if let error = error as NSError? {

            self.handleFailure(with: response, error: error, completion: completion)

        } else if let data = data {

            guard data.isEmpty == false else {

                completion(.failure(.emptyData))
                return
            }

            self.parse(data, completion: completion)

        } else {

            completion(.failure(.generic))
        }
    }

    func handleFailure<T: Codable>(with response: URLResponse?, error: NSError, completion: APICompletion<T>) {

        if let response = response {

            completion(.failure(.underlyingErrorResponse(error, response)))

        } else {

            completion(.failure(.underlyingError(error)))
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
}
