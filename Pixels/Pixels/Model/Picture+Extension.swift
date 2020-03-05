//
//  Picture+Extension.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import CoreData

extension Picture {
    
    convenience init(name: String ,picture: Data, pictureDescription: String, context: NSManagedObjectContext) {
        self.init(context:context)
        self.picture = picture
        self.pictureDescription = pictureDescription
        self.name = name
    }
}
