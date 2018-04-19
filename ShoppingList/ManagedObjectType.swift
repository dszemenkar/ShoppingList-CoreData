//
//  ManagedObjectType.swift
//  ShoppingList
//
//  Created by David Szemenkar on 2018-04-19.
//  Copyright © 2018 David Szemenkar. All rights reserved.
//

import Foundation

protocol ManagedObjectType: class {
    
    static var entityName: String { get }
    
}
