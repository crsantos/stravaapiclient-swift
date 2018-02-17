//
//  StravaAPIClientIntegrationTests.swift
//  crsantos.info
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation
import XCTest
@testable import StravaAPIClient

class StravaAPIClientIntegrationTests: XCTestCase {

    fileprivate enum Constants {

        static let clientId = "XXX"
        static let clientSecret = "XXX"
        static let redirectURL = "app://strava/oauth"
        static let accessToken = "XXX"
    }

    fileprivate var client: StravaAPIClient!

    override func setUp() {

        let config = StravaConfig(
            clientId: Constants.clientId,
            clientSecret: Constants.clientSecret,
            redirectURL: Constants.redirectURL,
            accessToken: Constants.accessToken
        )
        self.client = StravaAPIClient(with: config)
    }

    func testBootAPIClient() {

        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .success(athlete) = result {

                debugPrint("Got Athlete: \(athlete)")

            } else if case let .failure(error) = result {

                debugPrint("Error: \(error)")
            }
            expectation.fulfill()
        }
        let expectation2 = XCTestExpectation(description: "requestCurrentAthleteActivities")
        self.client.requestCurrentAthleteActivities { result in

            if case let .success(activities) = result {

                debugPrint("Got Activities: \(activities)")

            } else if case let .failure(error) = result {

                debugPrint("Error: \(error)")
            }
            expectation2.fulfill()
        }
        self.wait(for: [expectation, expectation2], timeout: 2.0)
    }
}
