//
//  Webservice.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 17/12/22.
//

import Foundation

// Comments: Webservice class to perform network layer operations
class Webservice {
    
    // MARK: Methods
    // Comments: Method to retrieve users list. and return it as part of result.
    func loadUsersList(completed : @escaping (Result<[UserDetails], ErrorMessage>) -> Void) {
        
        var userDetails = [UserDetails]()
        let sourceURL = URL(string :"https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTask(with: sourceURL) { data,resp, err in
            
            if let _ = err {
                completed(.failure(.invalidData))
                return
            }
            guard resp is HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                if let data = data {
                    userDetails = try JSONDecoder().decode([UserDetails].self, from: data)
                }
            }catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completed(.failure(.invalidData))
            }
            
            DispatchQueue.main.async {
                completed(.success(userDetails))
            }
        }.resume()
        
    }
    
}
