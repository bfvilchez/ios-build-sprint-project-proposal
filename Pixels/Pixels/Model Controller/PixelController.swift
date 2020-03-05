//
//  PixelController.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PixelController {
    
    private(set) var pictures = [Picture]()
    
    func createImage(WithName name: String, image: UIImage, pictureDescription:String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let image = image.jpegData(compressionQuality: 60) else { return }
        let picture = Picture(name: name, picture: image, pictureDescription: pictureDescription, context: context)
        pictures.append(picture)
        CoreDataStack.shared.mainContext.saveChanges()
    }
    
    func deleteImage() {}
    
    func signout() {
        let fetchRequest:NSFetchRequest<Picture> = NSFetchRequest(entityName: "Picture")
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try CoreDataStack.shared.mainContext.execute(deleteBatch)
        } catch {
            NSLog("failed to delete objects")
        }
    }
    
}
