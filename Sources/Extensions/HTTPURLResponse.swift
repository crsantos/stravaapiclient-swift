//
//  HTTPURLResponse.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 05/03/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

extension HTTPURLResponse {

    var hasAcceptableStatusCode: Bool {

        return (200...299 ~= self.statusCode)
    }
}
