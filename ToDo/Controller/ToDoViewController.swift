

import UIKit
import CoreData


class ToDoViewController: UITableViewController {

    var itemArray = ["Abc", "Def", "Ghi"]
    let defauls = UserDefaults.standard


    let dataFilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let items = defauls.array(forKey: "ToDoArray") as? [String] {
            itemArray = items
        }
        
    }

// MARK - Tableview Datasource Methos
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
 // MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
    
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
     
    }
    
    
// MARK - Add New Items
    
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "Enter data", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            print(textField.text!)
            self.itemArray.append(textField.text!)
            self.defauls.set(self.itemArray, forKey: "ToDoArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
            print(alertTextField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


