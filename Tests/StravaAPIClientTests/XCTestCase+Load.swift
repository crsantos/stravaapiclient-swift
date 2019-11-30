//
//  XCTestCase+Load.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation
import OHHTTPStubs
import XCTest

extension XCTestCase {

    private enum Constants {

        static let applicationJSON = ["Content-Type":"application/json"]
    }

    func mock(uri: String, jsonFilename: String){

        stub(condition: isPath(uri)) { _ in

            let stubPath = OHPathForFile(jsonFilename, type(of: self))
            return fixture(filePath: stubPath!,
                           headers: Constants.applicationJSON)
        }
    }

    func mockCorruptData(uri: String) {

        stub(condition: isPath(uri)) { _ in

            let data = Data([0,1,1,0,1])
            return OHHTTPStubsResponse(data: data,
                                       statusCode:200,
                                       headers: Constants.applicationJSON)
        }
    }

    func mockServerEmptyData(path: String) {

        stub(condition: isPath(path)) { _ in

            return OHHTTPStubsResponse(data: Data(),
                                       statusCode: 500,
                                       headers: Constants.applicationJSON)
        }
    }

    func mockServerErrorData(uri: String, jsonFilename: String, status: Int32 = 400, headers: [String:String]? = nil) {

        stub(condition: isPath(uri)) { _ in

            let stubPath = OHPathForFile(jsonFilename, type(of: self))
            return fixture(filePath: stubPath!,
                           status: status,
                           headers: headers)
        }
    }

    func mockServerError(path: String) {

        stub(condition: isPath(path)) { _ in

            return OHHTTPStubsResponse(error: NSError(domain: "D", code: 123456, userInfo: nil))
        }
    }
}
