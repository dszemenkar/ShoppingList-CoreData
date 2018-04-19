//
//  FetchedResultsProvider.swift
//  ShoppingList
//
//  Created by David Szemenkar on 2018-04-19.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import Foundation
import CoreData

protocol FetchedResultsProviderDelegate: class {
    
    func fetchedResultsProviderDidInsert(indexPath: IndexPath)
    func fetchedResultsProviderDidDelete(indexPath: IndexPath)
}

class FetchedResultsProvider<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate where T: ManagedObjectType {
    
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<T>!
    weak var delegate: FetchedResultsProviderDelegate!
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
        try! self.fetchedResultsController.performFetch()
    }
    
    func numberOfSections() -> Int {
        return (self.fetchedResultsController.sections?.count)!
    }
    func numberOfRowsInSection(section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }
    
    func objectAtIndex(indexPath: IndexPath) -> T {
        return self.fetchedResultsController.object(at: indexPath)
    }
    
    func delete(model: T) {
        self.managedObjectContext.delete(model)
        try! self.managedObjectContext.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            self.delegate.fetchedResultsProviderDidInsert(indexPath: newIndexPath!)
        } else if type == .delete {
            self.delegate.fetchedResultsProviderDidDelete(indexPath: indexPath!)
        }
        
    }
    
}
