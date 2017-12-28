//
//  HTTPRequester.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]
public typealias URLSessionDataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

struct HTTPRequester {

    fileprivate let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)

    @discardableResult
    func request(with request: URLRequest, completion: @escaping URLSessionDataTaskCompletion) -> URLSessionDataTask {

        let task = self.session.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
