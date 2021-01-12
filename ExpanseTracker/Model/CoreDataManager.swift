//
//  CoreDataManager.swift
//  ExpanseTracker
//
//  Created by Zindal on 12/01/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    static let shared : CoreDataManager! = CoreDataManager()
    
    func save(expnaseDict: [String:String]) -> Bool {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return false
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "ItemList", in: managedContext)!
      let items = NSManagedObject(entity: entity, insertInto: managedContext)
        items.setValue(expnaseDict["title"], forKeyPath: "title")
        items.setValue(expnaseDict["amount"], forKeyPath: "amount")
        items.setValue(expnaseDict["category"], forKeyPath: "category")
        items.setValue(expnaseDict["date"], forKeyPath: "date")
        items.setValue(expnaseDict["note"], forKeyPath: "note")

      do {
        try managedContext.save()
        return true
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        return false
      }
    }
    
    func fetch() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return []
        }

        var itemList: [NSManagedObject] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ItemList")

        do {
            itemList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return itemList
    }

}
