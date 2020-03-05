//
//  http+secured.swift
//  Pixels
//
//  Created by brian vilchez on 3/5/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation

extension URL {
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
