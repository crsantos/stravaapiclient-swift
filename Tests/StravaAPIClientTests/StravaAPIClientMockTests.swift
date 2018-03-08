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

    // MARK: Errors

    func testInvalidJSONResponseKeyNotFound() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_keynotfound")
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
        self.removeStub(stub)
    }

    func testInvalidJSONResponseTypeMismatch() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_typemismatch")
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
        self.removeStub(stub)
    }

    func testInvalidJSONResponseTypeDataCorrupted() {

        let stub = self.mockCorruptData(uri: "\(Constants.apiPrefix)/athlete")
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
        self.removeStub(stub)
    }

    func testInvalidJSONResponseTypeValueNotFound() {

        let stub = self.mock(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "current_athlete_200_invalid_valuenotfound")
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
        self.removeStub(stub)
    }

    // TODO: error

    func testError404NotFound() {

        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_notfound_404", status: 404)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError404")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case .notFound = apiError,
                errorModel.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    func testError403RateLimit() {

        let headers = [
            "X-RateLimit-Limit": "600,30000",
            "X-RateLimit-Usage": "642,27300"
        ]
        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403", status: 403, headers: headers)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403RateLimit")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case let .rateLimitingExceeded(limit, usage) = apiError,
                usage.shortTerm == 642,
                limit.longTerm == 30000,
                errorModel.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    func testError403InvalidRateLimit() {

        let headers = [
            "X-RateLimit-Limit": "30000",
            "X-RateLimit-Usage": "642"
        ]
        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403", status: 403, headers: headers)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403InvalidRateLimit")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case .forbidden = apiError,
                errorModel.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    func testError403Forbidden() {

        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_rate_limit_403", status: 403)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError403Forbidden")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case .forbidden = apiError,
                errorModel.errors.count == 1 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    func testError401Unauthorized() {

        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_unauthorized_401", status: 401)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError401")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case .unauthorized = apiError,
                errorModel.errors.count == 0 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    func testError500() {

        let stub = self.mockServerErrorData(uri: "\(Constants.apiPrefix)/athlete", jsonFilename: "error_unauthorized_401", status: 500)
        let expectation = XCTestExpectation(description: "requestCurrentAthleteError500")
        self.client.requestCurrentAthlete { result in

            if case let .failure(error) = result,
                case let .apiError(apiError, errorModel) = error,
                case .unknown = apiError,
                errorModel.errors.count == 0 {

                expectation.fulfill()

            } else {

                XCTFail("Result: \(result)")
            }
        }
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }

    // MARK: Resources
    
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
        self.wait(for: [expectation], timeout: 1.0)
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
        
        self.wait(for: [expectation], timeout: 1.0)
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
        
        self.wait(for: [expectation], timeout: 1.0)
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
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
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
        self.wait(for: [expectation], timeout: 1.0)
        self.removeStub(stub)
    }
}
