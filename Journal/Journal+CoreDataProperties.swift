//
//  Journal+CoreDataProperties.swift
//  
//
//  Created by CdxN on 2017/8/4.
//
//

import Foundation
import CoreData

extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: NSData?
    @NSManaged public var data: NSDate?
    @NSManaged public var dataString: String?
}
