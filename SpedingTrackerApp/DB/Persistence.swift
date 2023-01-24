//
//  Persistence.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 16.01.23.
//

import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SpedingTrackerApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        setInitialDataForTransactionCategory()
    }
    
    public func setInitialDataForTransactionCategory() {
        
        if UserDefaults.standard.bool(forKey: "KEY") { return }
        
        let viewContext = container.viewContext
        let category = TransactionCategory(context: viewContext)
        category.name = "Office Supplies"
        category.color = UIColor.blue.encode()
        category.timestamp = Date()
        
        try? viewContext.save()
        UserDefaults.standard.set(true, forKey: "KEY")
    }
}
