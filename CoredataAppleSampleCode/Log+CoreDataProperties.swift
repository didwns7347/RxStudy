//
//  Log+CoreDataProperties.swift
//  CoredataAppleSampleCode
//
//  Created by yangjs on 2022/10/28.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var regdate: Date?
    @NSManaged public var type: Int16
    @NSManaged public var relationship: Board?

}

extension Log : Identifiable {

}
