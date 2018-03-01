//
//  XCTestCase+Load.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation
import Mockingjay
import XCTest

extension XCTestCase {

    @discardableResult
    func mock(uri: String, verb: HTTPMethod = .get, jsonFilename: String) -> Stub {

        let path = Bundle(for: type(of: self)).path(forResource:jsonFilename, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return stub(http(verb, uri: uri), jsonData(data))
    }

    @discardableResult
    func mockServerEmptyData(path: String, verb: HTTPMethod = .get) -> Stub {

        return stub(http(verb, uri: path), http(500))
    }

    @discardableResult
    func mockServerError(path: String, verb: HTTPMethod = .get) -> Stub {

        return stub(http(verb, uri: path), failure(NSError(domain: "D", code: 123456, userInfo: nil)))
    }
}
