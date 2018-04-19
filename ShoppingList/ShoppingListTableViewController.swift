//
//  PlacesTableViewController.swift
//  Gylsboda
//
//  Created by David Szemenkar on 2018-04-18.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    var fetchResultsProvider: FetchedResultsProvider<ShoppingList>!
    var dataSource: TableViewDataSource<UITableViewCell,ShoppingList>!

    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        populateShoppingList()
    }
    
    private func populateShoppingList(){
        
        self.fetchResultsProvider = FetchedResultsProvider(managedObjectContext: self.managedObjectContext)
        self.dataSource = TableViewDataSource(cellIdentifier: "ShoppingListTableViewCell", tableView: self.tableView, fetchedResultsProvider: self.fetchResultsProvider) { cell, model in
                cell.textLabel?.text = model.title
            }
        
        self.tableView.dataSource = self.dataSource
    }    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let addNewItemView = AddNewItemView(controller: self, placeHolderText: "Enter a new item") { title in
            self.addNewShoppingList(title: title)
        }
        return addNewItemView
    }

    private func addNewShoppingList(title: String) {
        let shoppingList = NSEntityDescription.insertNewObject(forEntityName: "ShoppingList", into: self.managedObjectContext) as! ShoppingList
        shoppingList.title = title
        try! self.managedObjectContext.save()
    }
}
