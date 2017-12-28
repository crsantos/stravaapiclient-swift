//
//  Bike.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 27/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public struct Bike: Codable {

    let id: String
    let primary: Bool
    let name: String
    let distance: Double
    let resourceState: Int

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case primary = "primary"
        case name = "name"
        case distance = "distance"
        case resourceState = "resource_state"
    }

    init(id: String, primary: Bool, name: String, distance: Double, resourceState: Int) {

        self.id = id
        self.primary = primary
        self.name = name
        self.distance = distance
        self.resourceState = resourceState
    }
}

extension Bike {

    init?(data: Data) {

        guard let me = try? JSONDecoder().decode(Bike.self, from: data) else { return nil }
        self.init(id: me.id, primary: me.primary, name: me.name, distance: me.distance, resourceState: me.resourceState)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {

        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(url: String) {

        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {

        return try? JSONEncoder().encode(self)
    }

    var json: String? {

        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
