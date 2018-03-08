//
//  Data.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 06/03/2018.
//  Copyright © 2018 crsantos.info. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Data {

    enum DataResult {

        case data(Data)
        case empty
    }

    var unwrapped: DataResult {

        if let data = self,
            data.isEmpty == false {

            return .data(data)
        }
        return .empty
    }
}
