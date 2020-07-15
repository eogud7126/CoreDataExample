//
//  Entity.swift
//  CoreDataExample
//
//  Created by USER on 15/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit
import CoreData

extension Entity{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Thing");
    }
}
