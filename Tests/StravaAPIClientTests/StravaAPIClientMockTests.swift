//
//  StravaAPIClientMockTests.swift
//  StravaAPIClient
//
//  Created by Ricardo Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation
import XCTest
@testable import StravaAPIClient
import Mockingjay

class StravaAPIClientMockTests: XCTestCase {

    fileprivate enum Constants {

        static let clientId = "123456789"
        static let clientSecret = "s3cr3t"
        static let redirectURL = "app://strava/oauth"
        static let accessToken = "acc3sst0k3n"

        static let apiPrefix = "/api/v3"
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

    override func tearDown() {

        super.tearDown()
        self.removeAllStubs()
    }

    func testMockCurrentLoggedInAthleteOk() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .success(athlete) = result {

                XCTAssertNotNil(athlete)
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
        self.removeStub(stub)
    }

    /// Extensive error test to cover the .underlyingError case
    func testMockCurrentLoggedInAthleteErrorUnderlyingNSError() {

        let errorStub = self.mockServerError(path: "\(Constants.apiPrefix)/athlete")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(err) = result,
                case let .underlyingError(someNSError as NSError) = err,
                someNSError.domain == "D",
                someNSError.code == 123456 {

                expectation.fulfill()

            } else {

                XCTFail()
            }
        }

        self.wait(for: [expectation], timeout: 2.0)
        self.removeStub(errorStub)
    }

    /// Extensive error test to cover the .emptyData case
    func testMockCurrentLoggedInAthleteErrorEmptyData() {

        let errorStub = self.mockServerEmptyData(path: "\(Constants.apiPrefix)/athlete")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(err) = result,
                case .emptyData = err {

                expectation.fulfill()

            } else {

                XCTFail()
            }
        }

        self.wait(for: [expectation], timeout: 2.0)
        self.removeStub(errorStub)
    }

    func testCurrentAthleteActivitiesOk() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athlete/activities", jsonFilename: "athlete_activities_200")

        let expectation = XCTestExpectation(description: "requestCurrentAthleteActivities")
        self.client.requestCurrentAthleteActivities { result in

            if case let .success(activities) = result {

                XCTAssertNotNil(activities)
                XCTAssertEqual(activities.count, 3)
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
        self.removeStub(stub)
    }

    func testCurrentAthleteActivitiesError() {

        let errorStub = self.mockServerError(path: "\(Constants.apiPrefix)/athlete/activities")
        let errorExpectation = XCTestExpectation(description: "errorRequestCurrentAthleteActivities")
        self.client.requestCurrentAthleteActivities { result in
            
            if case .failure = result {

                errorExpectation.fulfill()

            } else{

                XCTFail()
            }
        }
        self.wait(for: [errorExpectation], timeout: 2.0)
        self.removeStub(errorStub)
    }

    func testCurrentAthleteStatsOk() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athletes/\(1234)/stats", jsonFilename: "athlete_stats_200")

        let expectation = XCTestExpectation(description: "requestCurrentAthleteStats")
        self.client.requestCurrentAthleteStats(athleteId: 1234) { result in

            if case let .success(stats) = result {

                XCTAssertNotNil(stats)
                XCTAssertEqual(stats.allRunTotals.count, 327)
                XCTAssertEqual(stats.allRideTotals.distance, 447541.0)
                XCTAssertEqual(stats.biggestClimbElevationGain, 350.6, accuracy: 0.01)
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 2.0)
        self.removeStub(stub)
    }

    func testCurrentAthleteStatsError() {

        let errorStub = self.mockServerError(path: "\(Constants.apiPrefix)/athletes/1234/stats")
        let errorExpectation = XCTestExpectation(description: "errorRequestCurrentAthleteStats")
        self.client.requestCurrentAthleteStats(athleteId: 1234) { result in

            if case .failure = result {

                errorExpectation.fulfill()

            } else{

                XCTFail()
            }
        }
        self.wait(for: [errorExpectation], timeout: 2.0)
        self.removeStub(errorStub)
    }
}
