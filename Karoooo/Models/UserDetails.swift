//
//  UserDetails.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 17/12/22.
//

import Foundation

// Comments: model having details of a single user.
struct UserDetails: Codable {
    // MARK: Properties
    var id :Int
    var name :String
    var email :String
    var phone: String
    var address: Address
    var company: CompanyDetails
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case address
        case company
    }
}


