//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Paul Barnes on 26/06/2020.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext () -> NSManagedObjectContext {
    // Initialise NSManagedObjectModel
    let modelURL = Bundle.main.url(forResource: "ShoutOut", withExtension: "momd")!
    print(modelURL)
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else { fatalError("Model not found")}
    
    // Configure NSPresistentStore
    let psc=NSPersistentStoreCoordinator(managedObjectModel: model)
    let storeURL = URL.documentsURL.appendingPathComponent("ShoutOut.sqlite")
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    
    // Create and return NSManagedObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}

extension URL {
    static var documentsURL: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! {get set}
}
