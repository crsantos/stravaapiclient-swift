//
//  Photos.swift
//  StravaAPIClient
//
//  Created by Ricardo Santos on 17/02/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

struct Photo: Codable {

    let id: JSONNull?
    let uniqueID: String
    let urls: [String: String]
    let source: Int

    enum CodingKeys: String, CodingKey {

        case id
        case uniqueID = "unique_id"
        case urls, source
    }
}
