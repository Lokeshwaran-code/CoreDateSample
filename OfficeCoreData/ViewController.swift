//
//  ViewController.swift
//  OfficeCoreData
//
//  Created by LOKESH on 24/06/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var finder = ["Dq", "Lokesh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adding users
        addUser(name: "Lokesh", phonenum: "12345")
        addUser(name: "saai", phonenum: "678901")
        addUser(name: "Akhash", phonenum: "68595")
        addUser(name: "Dq", phonenum: "549449")
        addUser(name: "Haie", phonenum: "57585")
        addUser(name: "Sathya", phonenum: "113242")
        addUser(name: "logu", phonenum: "898980")
        
        // Fetching users
        let users = fetchUsers()
        for user in users
        {
            print("Name: \(user.name ?? ""), Phone: \(user.phonenum ?? "")")
        }

        // Updating a user
        if users.count > 0
        {
            updateUser(user: users.first!, name: "Jane Doe", phonenum: "0987654321")
        }

        // Deleting a user
        if users.count > 0 
        {
            deleteUser(user: users.last!)
        }

        for name in finder 
        {
            let phoneNumber = findUserByName(name: name)
            if phoneNumber != nil 
            {
                print("Phone number for \(name): \(phoneNumber!)")
            } 
            else
            {
                print("User \(name) not found")
            }
        }
    }

    // Core Data operations (addUser, fetchUsers, updateUser, deleteUser)
    // ... (same as the functions defined above)

    // Create
    func addUser(name: String, phonenum: String)
    {
        let context = CoreDataManager.shared.context
        let user = User(context: context)
        user.name = name
        user.phonenum = phonenum

        CoreDataManager.shared.saveContext()
    }

    // Fetch
    func fetchUsers() -> [User]
    {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do 
        {
            let users = try context.fetch(fetchRequest)
            return users
        } 
        catch
        {
            print("Fetch failed")
            return []
        }
    }

    // Update
    func updateUser(user: User, name: String, phonenum: String)
    {
        let context = CoreDataManager.shared.context
        user.name = name
        user.phonenum = phonenum

        CoreDataManager.shared.saveContext()
    }

    // Delete
    func deleteUser(user: User) 
    {
        let context = CoreDataManager.shared.context
        context.delete(user)

        CoreDataManager.shared.saveContext()
    }

    // Find for the user name
    func findUserByName(name: String) -> String? 
    {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do
        {
            let users = try context.fetch(fetchRequest)
            return users.first?.phonenum
        }
        catch
        {
            print("Fetch by name failed")
            return nil
        }
    }
}



