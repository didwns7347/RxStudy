//
//  ViewController.swift
//  CoredataAppleSampleCode
//
//  Created by yangjs on 2022/10/28.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    lazy var list : [NSManagedObject] = {return self.fetch()}()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetch()-> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequset = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        let result = try? context.fetch(fetchRequset)
        result?.forEach({ object in
            let person = object as? Person
            print(person?.name ?? "nil")
        })
        return result ?? []
    }
    
    func save()->Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequset = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
        object.setValue("", forKey: <#T##String#>)
    }
}

