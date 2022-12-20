//
//  Authentication.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 19/12/22.
//

import Foundation

// Comments: model having credentials of a user.
struct Authentication: Codable {
    // MARK: Properties
    var id: Int
    var username: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case username
            case password
        }
    
}
