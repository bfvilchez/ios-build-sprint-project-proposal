//
//  User+Convenience.swift
//  Pixels
//
//  Created by brian vilchez on 3/4/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    convenience init(name:String, email:String, pictures: [Picture] = [], context: NSManagedObjectContext) {
        self.init(context:context)
        self.name = name
        self.email = email
        self.pictures = NSSet(array: pictures)
    }
}
