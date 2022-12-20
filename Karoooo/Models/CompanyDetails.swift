//
//  CompanyDetails.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 20/12/22.
//

import Foundation

// Comments: model having company details of a user.
struct CompanyDetails: Codable {
    // MARK: Properties
    var name: String
    var catchPhrase: String
    var bs: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}
