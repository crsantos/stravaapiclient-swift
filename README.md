# StravaAPIClient

![MIT Licence](https://img.shields.io/badge/license-MIT-blue.svg)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/stravaapiclient-swift.svg)](https://img.shields.io/cocoapods/v/stravaapiclient-swift.svg)
[![Platform](https://img.shields.io/cocoapods/p/stravaapiclient-swift.svg?style=flat)](http://cocoadocs.org/docsets/stravaapiclient-swift)
[![CircleCI](https://img.shields.io/circleci/project/github/crsantos/stravaapiclient-swift.svg)](https://circleci.com/gh/crsantos/stravaapiclient-swift) [![Coveralls github](https://img.shields.io/codecov/c/github/crsantos/stravaapiclient-swift/master.svg)](https://codecov.io/gh/crsantos/stravaapiclient-swift)
[![Maintainability](https://api.codeclimate.com/v1/badges/2ec7915dbe3d65c9749a/maintainability)](https://codeclimate.com/github/crsantos/stravaapiclient-swift/maintainability)

Simple and lightweight NSURLSession wrapper around Strava API.

## Motivation

When I first searched for any StravaAPI clients for iOS I found some old-fashioned obj-c like frameworks, but implemented in Swift, but not newer Swift. They were like Swift1 😔
They were old abandoned frameworks, so I decided to implement a newer Swift 4+ implementation.

### API

#### Usage

Create and pass a valid config object to `StravaAPIClient` and use the available methods to fetch anything from Strava API.

```swift
let config = StravaConfig(
  clientId: Constants.clientId,
  clientSecret: Constants.clientSecret,
  redirectURL: Constants.redirectURL,
  accessToken: Constants.accessToken
)
let client = StravaAPIClient(with: config)

// get current auth'd athlete
self.client.requestCurrentAthlete { result in

    if case let .success(athlete) = result {

        // use athlete
    }
}

// or get activities

self.client.requestCurrentAthleteActivities { result in

    if case let .success(activities) = result {

        // use list of activities
    }
}
```

#### Endpoints

This is still a WIP,  but I'm adding new requests. Feel free to contribute with some more.

#### `GET /athlete`

* Returns the authenticated athlete, retrieving an [`Athlete`](Sources/Models/Athlete.swift) object

#### `GET /athlete/activities`

* Returns the authenticated athlete's activity summaries, retrieving an [`SummaryActivity`](Sources/Models/SummaryActivity.swift) list

#### `GET /athletes/:id/stats`

*  Returns the target athlete's stats, retrieving an [`AthleteStats`](Sources/Models/AthleteStats.swift) object

### TODO

Please check [TODO.md](./TODO.md) doc
