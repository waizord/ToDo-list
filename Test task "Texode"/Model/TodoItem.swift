//
//  TodoItem.swift
//  Test task "Texode"
//
//  Created by Ivan on 8/12/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class TodoItem {
    var name: String
    var isComplete: Bool
    
    lazy var subItems = [TodoItem]()
    
    init(name: String) {
        self.name = name
        self.isComplete = false
        
    }
    
    func addSubItem(subItem: TodoItem){
        subItems.append(subItem)
    }
    
    func removeSubItem(index: Int){
        subItems.remove(at: index)
    }
    
    func renameSubItem(subItem: TodoItem, index: Int){
        subItems.remove(at: index)
        subItems.insert(subItem, at: index)
    }
// MARK: Save items
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
        self.isComplete = ((dictionary.object(forKey: "isComplete") ) != nil)
        
        let arraySubToDos = dictionary.object(forKey: "subToDos") as! NSArray
        for subToDoDic in arraySubToDos {
            self.subItems.append(TodoItem(dictionary: subToDoDic as! NSDictionary))
        }
    }
    var dictionary: NSDictionary {
        var arraySubToDos = NSArray()
        for subitem in subItems{
            arraySubToDos = arraySubToDos.adding(subitem.dictionary) as NSArray
        }
        let dictionary = NSDictionary(objects: [name, isComplete, arraySubToDos], forKeys: ["name" as NSCopying, "isComplete" as NSCopying,  "subToDos" as NSCopying])
        
        return dictionary
    }
}
