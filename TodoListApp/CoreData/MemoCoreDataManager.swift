//
//  MemoCoreDataManager.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/10/25.
//

import UIKit
import CoreData

final class MemoCoreDataManager {
    
    private static let context: NSManagedObjectContext? = {
        let appDelegate: AppDelegate = AppDelegate()
        return appDelegate.persistentContainer.viewContext
    }()
    
    static func saveData(_ memo: Memo) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(
            forEntityName: "MemoEntity",
            in: context
        ) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue(memo.uuid, forKey: "uuid")
        object.setValue(memo.title, forKey: "title")
        object.setValue(memo.content, forKey: "content")
        object.setValue(memo.date, forKey: "date")
        
        do {
            try context.save()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    static func fetchData() -> [Memo] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MemoEntity")
        
        do {
            guard let memoEntityList = try context.fetch(fetchRequest) as? [MemoEntity] else { return [] }
            var memoList: [Memo] = []
            memoEntityList.forEach {
                memoList.append(convertedToMemo($0))
            }
            return memoList
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return []
    }
    
    static func updateData(_ memo: Memo) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "MemoEntity")
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", memo.uuid.uuidString)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? NSManagedObject else { return }
            object.setValue(memo.title, forKey: "title")
            object.setValue(memo.content, forKey: "content")
            object.setValue(Date.now, forKey: "date")
            
            try context.save()
        } catch {
            print("error : \(error.localizedDescription)")
        }
    }
    
    static func deleteData(_ memo: Memo) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "MemoEntity")
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", memo.uuid.uuidString)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? NSManagedObject else { return }
            context.delete(object)
            
            try context.save()
        } catch {
            print("error : \(error.localizedDescription)")
        }
    }
    
    private static func convertedToMemo(_ memoEntity: MemoEntity) -> Memo {
        return Memo(
            uuid: memoEntity.uuid ?? UUID(),
            title: memoEntity.title ?? "",
            content: memoEntity.content ?? "",
            date: memoEntity.date ?? Date()
        )
    }
}
