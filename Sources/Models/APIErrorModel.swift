//
//  APIError.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 03/03/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

public struct StravaAPIErrorModel: Codable {

    let message: String
    let errors: [StravaAPIErrorElement]

    enum CodingKeys: String, CodingKey {

        case message
        case errors
    }
}

public struct StravaAPIErrorElement: Codable {

    let resource: String
    let field: String
    let code: String

    enum CodingKeys: String, CodingKey {

        case resource
        case field
        case code
    }
}
