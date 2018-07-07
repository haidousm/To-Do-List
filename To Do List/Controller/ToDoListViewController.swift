//
//  ViewController.swift
//  To Do List
//
//  Created by Moussa on 7/7/18.
//  Copyright © 2018 Moussa. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "toDoItemArray") as? [Item]{
            
            itemArray = items
            
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = itemArray[indexPath.row]
        
        selectedItem.isDone = !selectedItem.isDone
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add What You Wanna Do!", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let toDoItemText = alertTextField.text {
            
                let newItem = Item()
                newItem.title = toDoItemText
                
                self.itemArray.append(newItem);
                
                self.defaults.set(self.itemArray, forKey: "toDoItemArray")
                
                self.tableView.reloadData();
                
            }
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Item"
            alertTextField = textField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
