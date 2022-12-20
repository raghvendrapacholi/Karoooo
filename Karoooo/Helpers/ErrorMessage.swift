//
//  ErrorMessage.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 20/12/22.
//

import Foundation


// Comments: Enum to show error messages from user actions.
enum ErrorMessage: String, Error {
    // MARK: Cases
    case invalidData = "Sorry. Somthing went wrong, try again."
    case invalidResponse = "Server error. Please modify your search and try again."
    case emptyCredentials = "Please enter required credentials."
    case invalidCredentials = "Entered username and password is incorrect."
}
