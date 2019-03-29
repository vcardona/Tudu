//
//  CategoryViewController.swift
//  Tudu
//
//  Created by Victor Hugo on 3/6/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController
{

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        loadCategories()
        
        tableView.rowHeight = 80.0
    }

    // MARK: - Table view data source
    @IBAction func addButtonPressd(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory  = Category()
            newCategory.name = textField.text!
    
            
            
            self.save(category: newCategory)
            
        }
        
        

        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //    MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories Added Yet"
        
        
        return cell
    }
    
    //    MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //    MARK: Data Manipulation Methods
    
    func save(category: Category)
    {
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving Categories\(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories()
    {
        categories = realm.objects(Category.self)
        
        //Todo el siguiente código que es de CoreData, lo reemplazamos con la línea anterior usando Realm.
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//            categories = try context.fetch(request)
//        }
//        catch
//        {
//            print("Error loading categories\(error)")
//        }
        
        tableView.reloadData()
    }
    
    //    MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath)
    {
        if let categoryForDeletion = self.categories?[indexPath.row]
        {
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting cateogry\(error)")
            }
        }
    }
}
