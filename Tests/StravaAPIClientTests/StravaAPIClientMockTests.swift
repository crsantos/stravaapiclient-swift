//
//  StravaAPIClientMockTests.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation
import XCTest
@testable import StravaAPIClient
import OHHTTPStubs

class StravaAPIClientMockTests: XCTestCase {
    
    private enum Constants {
        
        static let clientId = "123456789"
        static let clientSecret = "s3cr3t"
        static let redirectURL = "app://strava/oauth"
        static let accessToken = "acc3sst0k3n"
        
        static let apiPrefix = "/api/v3"
    }
    
    private var client: StravaAPIClient!
    
    override func setUp() {

        super.setUp()

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
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Errors

    func testInvalidJSONResponseKeyNotFound() {

        self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_keynotfound.json")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .parsingError(parseError) = error,
                case let .decode(decodingError) = parseError,
                case let DecodingError.keyNotFound(codingKey, _) = decodingError {

                XCTAssertEqual(codingKey.stringValue, "resource_state")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testInvalidJSONResponseTypeMismatch() {

        self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_typemismatch.json")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .parsingError(parseError) = error,
                case let .decode(decodingError) = parseError,
                case let DecodingError.typeMismatch(_, context) = decodingError {

                XCTAssertEqual(context.codingPath.first!.stringValue, "id")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testInvalidJSONResponseTypeDataCorrupted() {

        self.mockCorruptData(uri: "\(Constants.apiPrefix)/athlete")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .parsingError(parseError) = error,
                case let .decode(decodingError) = parseError,
                case let DecodingError.dataCorrupted(context) = decodingError {

                XCTAssertEqual(context.debugDescription, "The given data was not valid JSON.")

                if let error = context.underlyingError as NSError? {

                    XCTAssertEqual(error.code, 3840)
                    expectation.fulfill()

                } else {

                    XCTFail("🤔")
                }

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testInvalidJSONResponseTypeValueNotFound() {

        self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_valuenotfound.json")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .parsingError(parseError) = error,
                case let .decode(decodingError) = parseError,
                case let DecodingError.valueNotFound(_, context) = decodingError {

                XCTAssertEqual(context.codingPath.first!.stringValue, "id")
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    // TODO: error

    func testError404NotFound() {

        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_notfound_404.json", status: 404)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError404")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case .notFound = apiError.errorType,
                apiError.errorModel?.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testError403RateLimit() {

        let headers = [
            "X-RateLimit-Limit": "600,30000",
            "X-RateLimit-Usage": "642,27300"
        ]
        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403.json", status: 403, headers: headers)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403RateLimit")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case let .rateLimitingExceeded(limit, usage) = apiError.errorType,
                usage.shortTerm == 642,
                limit.longTerm == 30000,
                apiError.errorModel?.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testError403InvalidRateLimit() {

        let headers = [
            "X-RateLimit-Limit": "30000",
            "X-RateLimit-Usage": "642"
        ]
        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403.json", status: 403, headers: headers)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403InvalidRateLimit")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case .forbidden = apiError.errorType,
                apiError.errorModel?.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testError403Forbidden() {

        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403.json", status: 403)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403Forbidden")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case .forbidden = apiError.errorType,
                apiError.errorModel?.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testError401Unauthorized() {

        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_unauthorized_401.json", status: 401)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError401")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case .unauthorized = apiError.errorType,
                apiError.errorModel?.errors.count == 0 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testError500() {

        self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_unauthorized_401.json", status: 500)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError500")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError) = error,
                case .serverError = apiError.errorType,
                apiError.errorModel?.errors.count == 0 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    // MARK: Resources
    
    func testMockCurrentLoggedInAthleteOk() {
        
        self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200.json")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in
            
            if case let .success(athlete) = result {
                
                XCTAssertNotNil(athlete)
                expectation.fulfill()
                
            } else if case let .failure(error) = result {
                
                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    /// Extensive error test to cover the .underlyingError case
    func testMockCurrentLoggedInAthleteErrorUnderlyingNSError() {
        
        self.mockServerError(path: "\(Constants.apiPrefix)/athlete")
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
        
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    /// Extensive error test to cover the .emptyData case
    func testMockCurrentLoggedInAthleteErrorEmptyData() {
        
        self.mockServerEmptyData(path: "\(Constants.apiPrefix)/athlete")
        let expectation = XCTestExpectation(description: "requestCurrentAthlete")
        self.client.requestCurrentAthlete { result in
            
            if case let .failure(err) = result,
                case .emptyData = err {
                
                expectation.fulfill()
                
            } else {
                
                XCTFail()
            }
        }
        
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testCurrentAthleteActivitiesOk() {
        
        self.mock(uri: "\(Constants.apiPrefix)/athlete/activities", jsonFilename: "athlete_activities_200.json")
        
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
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testCurrentAthleteStatsOk() {
        
        self.mock(uri: "\(Constants.apiPrefix)/athletes/\(1234)/stats", jsonFilename: "athlete_stats_200.json")
        
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
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testRequestCurrentAthleteClubsOk() {

        self.mock(uri: "\(Constants.apiPrefix)/athlete/clubs", jsonFilename: "athlete_clubs_200.json")

        let expectation = XCTestExpectation(description: "requestCurrentAthleteClubs")
        self.client.requestCurrentAthleteClubs { result in

            if case let .success(clubs) = result {

                XCTAssertNotNil(clubs)
                XCTAssertEqual(clubs.count, 1)
                XCTAssertEqual(clubs.first?.profile, "https://dgalywyr863hv.cloudfront.net/pictures/clubs/231407/5319085/1/large.jpg")
                XCTAssertEqual(clubs.first?.city, "San Francisco")
                XCTAssertEqual(clubs.first?.country, "United States")
                XCTAssertEqual(clubs.first?.verified, true)
                XCTAssertEqual(clubs.first?.featured, false)
                XCTAssertEqual(clubs.first?.coverPhoto, "https://dgalywyr863hv.cloudfront.net/pictures/clubs/231407/5098428/4/large.jpg")

                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }

    func testActivityByIdOk() {

        self.mock(uri: "\(Constants.apiPrefix)/activities/1234", jsonFilename: "activity_by_id.json")

        let expectation = XCTestExpectation(description: "requestActivityById")
        self.client.requestActivity(activityId: 1234) { result in

            if case let .success(activity) = result {

                XCTAssertNotNil(activity)
                XCTAssertEqual(activity.id, 12345678987654321)
                XCTAssertEqual(activity.athlete.id, 134815)
                XCTAssertEqual(activity.calories, 870.2)
                XCTAssertEqual(activity.athleteCount, 1)
                XCTAssertEqual(activity.totalElevationGain, 516)
                XCTAssertEqual(activity.kudosCount, 19)
                XCTAssertEqual(activity.startLatlng?.first, 37.83)
                expectation.fulfill()

            } else if case let .failure(error) = result {

                XCTFail("Error: \(error)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
    }
}
