//
//  URLResourceRequestConvertible.swift
//  StravaAPIClient
//
//  Created by Carlos Santos on 28/12/2017.
//  Copyright © 2017 crsantos.info. All rights reserved.
//

import Foundation

public protocol URLResourceRequestConvertible {

    var asURLRequest: URLRequest { get }
}

public protocol URLResourceConvertible {

    var asURL: URL { get }
}

public protocol RequestSerializable {

    init(with config: AuthenticatableConfig)

    func serializeResource(_ resourceRequestConvertible: URLResourceRequestConvertible) -> URLRequest
}
