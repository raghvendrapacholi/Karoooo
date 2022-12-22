//
//  UsersListViewController.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 17/12/22.
//

import Foundation
import UIKit

class UsersListViewController : UITableViewController {
    
    // MARK: Properties
    private var webservice :Webservice!
    var usersListViewModel :UsersListViewModel!
    private var dataSource :TableViewDataSource<UsersTableViewCell,UserDetailsViewModel>!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.webservice = Webservice()
        self.usersListViewModel = UsersListViewModel(webservice: self.webservice) {
            
            self.dataSource = TableViewDataSource(cellIdentifier: "Cell", items: self.usersListViewModel.usersDetailsViewModel) { cell, vm in
                
                cell.nameLabel.text = vm.name
                cell.emailLabel.text = vm.email
                cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
                UIView.animate(withDuration: 0.3, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
                },completion: { finished in
                    UIView.animate(withDuration: 0.1, animations: {
                        cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    })
                })
            }
            
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }
    
    // Comments: Method to perform initial setup for view.
    func setup() {
        self.navigationItem.title = "Users"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = .darkGray
    }
    
}

extension UsersListViewController {
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewControllerIdentifier") as? UserDetailViewController
        userDetailViewController?.userDetailsViewModel = self.usersListViewModel.sourceAt(index: indexPath.row)
        self.navigationController?.pushViewController(userDetailViewController!, animated: true)
    }
}
