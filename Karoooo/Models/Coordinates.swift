//
//  Coordinates.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 20/12/22.
//

import Foundation

// Comments: model having coordinates details of a user.
struct Coordinates: Codable {
    
    // MARK: Properties
    var lat: String
    var lng: String
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
