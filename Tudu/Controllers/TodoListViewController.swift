//
//  ViewController.swift
//  Tudu
//
//  Created by Victor Hugo on 2/26/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController
{

    var todoItems : Results<Item>?
//    Se reemplaza esta opción de almacenar los datos por el FileManager
//    let defaults = UserDefaults.standard
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    //        Se modifica esta línea para crear nuestro propio plist.
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
        
//        loadItems()
        
    }

    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]
        {

            cell.textLabel?.text = item.title
        
// reemplazar el siguiente if con un operador ternario de esta forma ahorramos líneas de código.
        //  value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done  ? .checkmark : .none
        }
        else
        {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        print(itemArray[indexPath.row])
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    //realm.delete(item) al agregar esta línea podemos eliminar el contenido
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //Esta línea reemplaza todo lo que tenemos en el if, es una forma más elegante de hacerlo.
//        if itemArray[indexPath.row].done == false
//        {
//            itemArray[indexPath.row].done = true
//        }
//        else
//        {
//            itemArray[indexPath.row].done = false
//        }
        
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Tudu Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
         
            
            //            Modificamos la siguiente línea que estaba generando el crash al agregar nuevos datos
            //            en la lista
            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //            Con el cambio realizado con la nueva plist, usamos el siguiente procedimiento
            //            para almacenar los datos.
            
            if let currentCategory = self.selectedCategory
            {
                do
                {
                    try self.realm.write
                    {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }
                catch
                {
                    print("Error saving new items, \(error)")
                }
                
            }

            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems()
    {
//        Esta variable se comenta debido a que al usr CORE DATA no la necesitamos.
//        let encoder = PropertyListEncoder()
        
//        do{
//            try context.save()
//        }
//        catch
//        {
//            print("Error saving context, \(error)")
//        }
        
        self.tableView.reloadData()
    }
    
//    Se puede llamar entregando un argumento o sin el argumento, ya que se le da uno por defecto
//    De esta forma podemos usarla tanto para cargar todos nuestros datos, como para buscar uno en especifico.
//    por esto se comenta la línea let request : NSFetchRequest<Item> = Item.fetchRequest()
    func loadItems()
    {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        let request : NSFetchRequest<Item> = Item.fetchRequest()

//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
//        }
//        else
//        {
//            request.predicate = categoryPredicate
//        }
//
//        do{
//           itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \(error)")
//        }

        tableView.reloadData()
    }
//
    
    
}

//MARK: Search bar methods

extension TodoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
//
//         La línea anterior reemplaza todo el bloque de código que esta a continuación.
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.predicate = predicate
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count == 0
        {
            loadItems()

            DispatchQueue.main.async
            {
                searchBar.resignFirstResponder()
            }


        }
    }
}
