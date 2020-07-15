//
//  ViewController.swift
//  CoreDataExample
//
//  Created by USER on 15/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {


    //MARK: Properties
    
    
    @IBOutlet weak var tableView: UITableView!
    var people: [NSManagedObject] = []
    
    
    //MARK: ACTION
    @IBAction func addName(_ sender: Any) {
        
        //alert 버튼 생성
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else{
                return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    //MARK: func
    
    //Core Data
    func save(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        person.setValue(name, forKeyPath: "name")
        
        //4
        do{
            try managedContext.save()
            people.append(person)
        }catch let error as NSError{
            print("could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


}

//MARK: UITableVieDataSource

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
    }
}
