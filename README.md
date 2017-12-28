# StravaAPIClient

[![CircleCI](https://img.shields.io/circleci/project/github/crsantos/stravaapiclient-swift.svg)]() [![Coveralls github](https://img.shields.io/coveralls/github/crsantos/stravaapiclient-swift.svg)]()

Simple and lightweight NSURLSession wrapper around Strava API.

## Motivation

When I first searched for any StravaAPI clients for iOS I found some old-fashioned obj-c like frameworks, but implemented in Swift, but not Swft4 or 3. They were like Swift1 😔
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

self.client.requestCurrentAthlete { result in

    if case let .success(athlete) = result {

        // use athlete
    }
}
```

#### Endpoints

This is still a WIP,  but I will add new requests **soon**.

#### `GET https://www.strava.com/api/v3/athlete`

* `/athlete` - Returns the authenticated athlete, retrieving an `Athlete` object

### TODO

Some missing tasks:

- [ ] Add more endpoints
- [ ] Add mock tests for those endpoints
- [ ] Add CI integration
