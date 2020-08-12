//
//  TableViewController.swift
//  Test task "Texode"
//
//  Created by Ivan on 8/12/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var toDoItemCurrent: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItemCurrent == nil {
            toDoItemCurrent = rootItem
        }
        
        navigationItem.title = toDoItemCurrent?.name
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Create new item", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "ToDo item"
        }
        let alertActionCrate = UIAlertAction(title: "Create", style: .default) { (_) in
            if alert.textFields![0].text != ""{
                let newItem = TodoItem(name: alert.textFields![0].text!)
                self.toDoItemCurrent?.addSubItem(subItem: newItem)
                self.tableView.reloadData()
                saveData()
            }
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
        alert.addAction(alertActionCrate)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
        saveData()
    }
    
    @IBAction func longPressEditAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let pointPress = sender.location(in: tableView)
            //print(pointPress)
            if let indexPath = tableView.indexPathForRow(at: pointPress){
                //print(indexPath)
            let cell = tableView.cellForRow(at: indexPath)
                
                let alert = UIAlertController(title: "Edit post", message: "", preferredStyle: .alert)
                alert.addTextField { (textFild) in
                    if let text = cell?.textLabel?.text {
                        textFild.text = text
                    }
                }
        
                let alertActionEdit = UIAlertAction(title: "Edit", style: .default) { (_) in
                    if alert.textFields![0].text != ""{
                        let newItem = TodoItem(name: alert.textFields![0].text!)
                        self.toDoItemCurrent?.renameSubItem(subItem: newItem, index: indexPath.row)
                        self.tableView.reloadData()
                        saveData()
                    }
                }
                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
                alert.addAction(alertActionEdit)
                alert.addAction(alertActionCancel)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemCurrent?.subItems.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let itemForCell = toDoItemCurrent?.subItems[indexPath.row]
        cell.textLabel?.text = itemForCell?.name
        return cell
    }
    
    // MARK: - Next view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subItem = toDoItemCurrent?.subItems[indexPath.row]
        let tvc = storyboard?.instantiateViewController(identifier: "todoID") as! TableViewController
        tvc.toDoItemCurrent = subItem
        navigationController?.pushViewController(tvc, animated: true)
    }
    
    // MARK: - Delete cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItemCurrent?.removeSubItem(index: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
