//
//  Board+CoreDataProperties.swift
//  CoredataAppleSampleCode
//
//  Created by yangjs on 2022/10/28.
//
//

import Foundation
import CoreData


extension Board {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Board> {
        return NSFetchRequest<Board>(entityName: "Board")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var regdate: Date?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Board {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Log)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Log)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension Board : Identifiable {

}
