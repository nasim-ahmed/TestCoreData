//
//  Photo+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Research on 8/23/17.
//  Copyright © 2017 HealthDiary. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var author: String?
    @NSManaged public var mediaURL: String?
    @NSManaged public var tags: String?

}
