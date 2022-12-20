//
//  UsersListViewModel.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 17/12/22.
//

import Foundation

// Comments: ViewModel to populate tableView with users data. It also provide user at a certain index in usersDetailsViewModel
class UsersListViewModel {
    
    // MARK: Properties
    private var webservice :Webservice
    private (set) var usersDetailsViewModel :[UserDetailsViewModel] = [UserDetailsViewModel]()
    private var completion :() -> () = {  }
    
    // MARK: Intialisers
    init(webservice :Webservice, completion:@escaping () -> ()) {
        self.webservice = webservice
        self.completion = completion
        populateSources()
    }
    
    // MARK: Methods
    // Comments: Method to populate tableView with users data
    private func populateSources() {
        
        self.webservice.loadUsersList { result in
            switch result {
            case .success(let userDetailsList) :
                self.usersDetailsViewModel = userDetailsList.map(UserDetailsViewModel.init)
                self.completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Comments: It also providing user at a certain index in usersDetailsViewModel
    func sourceAt(index :Int) -> UserDetailsViewModel {
        return self.usersDetailsViewModel[index]
    }
}
