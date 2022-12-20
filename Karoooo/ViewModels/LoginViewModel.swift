//
//  LoginViewModel.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 19/12/22.
//

import Foundation

class LoginViewModel {
    
    // MARK: Properties
    var db:DBHelper = DBHelper()
    
    
    // MARK: Methods
    // Comments: Method to perform login validation and credentials check.
    func checkLogin(username: String?, password: String?, country: String?, completed : @escaping (Result<Bool, ErrorMessage>) -> Void) {
        
        if username != "", password != "", country != "" {
            let credentials = db.read()
            
            if credentials?.username == username && credentials?.password == password {
                completed(.success(true))
            }else {
                completed(.failure(.invalidCredentials))
            }
           
        }else{
            completed(.failure(.emptyCredentials))
        }
    } 
}
