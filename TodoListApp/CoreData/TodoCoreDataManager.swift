//
//  TodoCoreDataManager.swift
//  TodoListApp
//
//  Created by 최낙주 on 3/10/25.
//

import UIKit
import CoreData

final class TodoCoreDataManager {
    
    private static let context: NSManagedObjectContext? = {
        let appDelegate: AppDelegate = AppDelegate()
        return appDelegate.persistentContainer.viewContext
    }()
    
    static func saveData(_ todo: Todo) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(
            forEntityName: "TodoEntity",
            in: context
        ) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue(todo.uuid, forKey: "uuid")
        object.setValue(todo.title, forKey: "title")
        object.setValue(todo.time, forKey: "time")
        object.setValue(todo.day, forKey: "day")
        object.setValue(todo.selected, forKey: "isSelected")
        
        do {
            try context.save()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    static func fetchData() -> [Todo] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TodoEntity")
        
        do {
            guard let todoEntityList = try context.fetch(fetchRequest) as? [TodoEntity] else { return [] }
            var todoList: [Todo] = []
            todoEntityList.forEach {
                todoList.append(convertedToTodo($0))
            }
            todoList.sort { first, second in
                return first.day == second.day ? first.time > second.time : first.day > second.day
            }
            return todoList
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return []
    }
    
    static func deleteData(_ todo: Todo) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoEntity")
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", todo.uuid.uuidString)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? NSManagedObject else { return }
            context.delete(object)
            
            try context.save()
        } catch {
            print("error : \(error.localizedDescription)")
        }
    }
    
    private static func convertedToTodo(_ todoEntity: TodoEntity) -> Todo {
        return Todo(
            uuid: todoEntity.uuid ?? UUID(),
            title: todoEntity.title ?? "",
            time: todoEntity.time ?? Date(),
            day: todoEntity.day ?? Date(),
            selected: todoEntity.isSelected
        )
    }
}
