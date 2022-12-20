//
//  UserDetailsViewModel.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 20/12/22.
//

import Foundation

class UserDetailsViewModel {
    
    // MARK: Properties
    var id :Int
    var name :String
    var email :String
    var phone: String
    var address: Address
    var company: CompanyDetails
    
    // MARK: Initialisers
    init(userDetails :UserDetails) {
        self.id = userDetails.id
        self.name = userDetails.name
        self.email = userDetails.email
        self.phone = userDetails.phone
        self.address = userDetails.address
        self.company = userDetails.company
    }
    
    init(id :Int, name :String, email :String,phone: String, address :Address,company :CompanyDetails) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.company = company
    }
}
