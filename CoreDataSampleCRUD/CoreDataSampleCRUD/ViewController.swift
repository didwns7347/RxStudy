//
//  ViewController.swift
//  CoreDataSampleCRUD
//
//  Created by yangjs on 2022/10/06.
//

import UIKit
import CoreData

struct Person {
    var name : String
    var phoneNumber : String
    var shortcutNumber : Int
}
class ViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad")
        fetchData()
        saveData()
       
        
    }
    
    func saveData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let yangjs = Person(name: "jsYang", phoneNumber: "010-3021-7347", shortcutNumber: Int.random(in: (0...10)))
        // Do any additional setup after loading the view.
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        if let entity = entity{
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(yangjs.name, forKey: "name")
            person.setValue(yangjs.phoneNumber, forKey: "phoneNumber")
            person.setValue(yangjs.shortcutNumber, forKey: "shortcutNumber")
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        do{
            let contact = try context.fetch(Contact.fetchRequest()) as! [Contact]
            contact.forEach{
                print($0.name,$0.phoneNumber,$0.shortcutNumber)
            }
         }
        catch{
            print(error.localizedDescription)
        }
    }


}

