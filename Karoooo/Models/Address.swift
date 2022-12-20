//
//  Address.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 20/12/22.
//

import Foundation

// Comments: model having address details of a user.
struct Address: Codable {
    
    // MARK: Properties
    var geo: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case geo
    }
    
}
