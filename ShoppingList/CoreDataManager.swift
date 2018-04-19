//
//  CoreDataManager.swift
//  Gylsboda
//
//  Created by David Szemenkar on 2018-04-19.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var managedObjectContext: NSManagedObjectContext!
    
    func initializeCoreDataStack() {
        
        guard let modelURL = Bundle.main.url(forResource: "MyGroceryDataModel", withExtension: "momd") else {
            fatalError("GroceryDataModel not found")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to initialize ManagedObjectModel")
        }
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let fileManager = FileManager()
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get documents URL")
        }
        let storeURL = documentsURL.appendingPathComponent("MyGrocery.sqlite")
        
        print(storeURL)
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        let type = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: type)
        self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
}
