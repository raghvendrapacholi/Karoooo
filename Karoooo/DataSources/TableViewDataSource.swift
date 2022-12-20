//
//  TableViewDataSource.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 18/12/22.
//

import Foundation
import UIKit


// Comments: DataSource to prepare table view cell and render it to screen.
class TableViewDataSource<Cell :UITableViewCell,ViewModel> : NSObject, UITableViewDataSource {
    
    // MARK: Properties
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    var configureCell :(Cell,ViewModel) -> ()
    
    // MARK: Initialisers
    init(cellIdentifier :String, items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}
