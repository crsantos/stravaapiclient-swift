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

    private enum Constants {

        static let clientId = "XXX"
        static let clientSecret = "XXX"
        static let redirectURL = "app://strava/oauth"
        static let accessToken = "XXX"
    }

    private var client: StravaAPIClient!

    override func setUp() {

        let config = StravaConfig(
            clientId: Constants.clientId,
            clientSecret: Constants.clientSecret,
            redirectURL: Constants.redirectURL,
            accessToken: Constants.accessToken
        )
        self.client = StravaAPIClient(with: config)
    }

    func testRequestCurrentAthleteIntegration() {

        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .success(athlete) = result {

                debugPrint("Got Athlete: \(athlete)")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
    }

    func testRequestCurrentAthleteActivitiesIntegration() {

        let expectation = XCTestExpectation(description: "requestCurrentAthleteActivities")
        self.client.requestCurrentAthleteActivities { result in

            if case let .success(activities) = result {

                debugPrint("Got Activities: \(activities)")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
    }

    func testRequestCurrentAthleteStatsIntegration() {

        let expectation = XCTestExpectation(description: "requestCurrentAthleteStats")
        self.client.requestCurrentAthleteStats(athleteId: 4246969) { result in

            if case let .success(stats) = result {

                debugPrint("Got Stats: \(stats)")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
    }

    func testRequestCurrentAthleteClubsIntegration() {

        let expectation = XCTestExpectation(description: "requestCurrentAthleteClubs")
        self.client.requestCurrentAthleteClubs { result in

            if case let .success(stats) = result {

                debugPrint("Got Clubs: \(stats)")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
}
