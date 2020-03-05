//
//  NSManagedObjectContext.swift
//  Pixels
//
//  Created by brian vilchez on 3/4/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
  
    func saveChanges() {
        if hasChanges {
            do {
                try save()
            } catch {
                NSLog("failed to save changes: \(error)")
                 reset()
            }
        }
    }
}
