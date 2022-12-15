//
//  Computer+CoreDataProperties.swift
//  CoredataAppleSampleCode
//
//  Created by yangjs on 2022/10/28.
//
//

import Foundation
import CoreData


extension Computer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Computer> {
        return NSFetchRequest<Computer>(entityName: "Computer")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var model: String?
    @NSManaged public var owner: String?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Computer {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Person)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Person)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension Computer : Identifiable {

}
