//
//  Contact+CoreDataProperties.swift
//  CoreDataSampleCRUD
//
//  Created by yangjs on 2022/10/06.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var shortcutNumber: Int16
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension Contact : Identifiable {

}
