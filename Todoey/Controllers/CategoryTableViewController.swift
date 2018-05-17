//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Bionic Technology Group on 5/16/18.
//  Copyright © 2018 Rafael Sanchez. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    //Declare global constants/variables
    var categories = [Category]()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    
    
    //Mark - tableview datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    // Mark: - tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (alert) in
            
        let newCategory : Category = Category(context: self.context)
            newCategory.name = textfield.text!
            
        self.categories.append(newCategory)
        self.saveCategory()
            
            }
        alert.addTextField {
            (alertextfield) in
            alertextfield.placeholder = "Create New Category"
            textfield = alertextfield
        }
    
    alert.addAction(action)
        
    present(alert,animated: true, completion: nil)
    
        
    }
    func saveCategory(){
        
        do {
            try context.save()
        } catch {
            print("Rafa - Error saving the category: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Rafa - Error Loading Category \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    //Mark: - data manipulation method
    //save
    //load
    
}
