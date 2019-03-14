//
//  CategoryViewController.swift
//  Tudu
//
//  Created by Victor Hugo on 3/6/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController
{

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        loadCategories()
    }

    // MARK: - Table view data source
    @IBAction func addButtonPressd(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory  = Category(context: self.context)
            newCategory.name = textField.text!
    
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //    MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    //    MARK: Data Manipulation Methods
    
    func saveCategories()
    {
        do{
        try context.save()
        }
        catch{
            print("Error saving Categories\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories()
    {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        }
        catch
        {
            print("Error loading categories\(error)")
        }
        
        tableView.reloadData()
    }
    
    //    MARK: Add New Categories
}
