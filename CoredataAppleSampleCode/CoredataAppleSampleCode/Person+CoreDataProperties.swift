//
//  Person+CoreDataProperties.swift
//  CoredataAppleSampleCode
//
//  Created by yangjs on 2022/10/28.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var gender: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var relationship: Computer?

}

extension Person : Identifiable {

}
