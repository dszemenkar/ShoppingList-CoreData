//
//  TableViewDataSource.swift
//  ShoppingList
//
//  Created by David Szemenkar on 2018-04-19.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import UIKit
import CoreData

class TableViewDataSource<Cell: UITableViewCell, Model: NSManagedObject>: NSObject, UITableViewDataSource, FetchedResultsProviderDelegate where Model: ManagedObjectType {
    
    var cellIdentifier: String!
    var fetchedResultsProvider: FetchedResultsProvider<Model>!
    var configureCell: (Cell, Model) -> ()
    var tableView: UITableView!
    
    init(cellIdentifier: String, tableView: UITableView, fetchedResultsProvider: FetchedResultsProvider<Model>, configureCell: @escaping (Cell, Model) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.fetchedResultsProvider = fetchedResultsProvider
        self.configureCell = configureCell
        self.tableView = tableView
        super.init()
        self.fetchedResultsProvider.delegate = self
    }
    
    func fetchedResultsProviderDidDelete(indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func fetchedResultsProviderDidInsert(indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsProvider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsProvider.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = self.fetchedResultsProvider.objectAtIndex(indexPath: indexPath)
            self.fetchedResultsProvider.delete(model: model)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let model: Model = self.fetchedResultsProvider.objectAtIndex(indexPath: indexPath)
        self.configureCell(cell, model)
        return cell
    }
}
