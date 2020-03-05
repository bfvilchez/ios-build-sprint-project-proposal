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
import Firebase
import FirebaseAuth

class PixelController {
    
    private(set) var pictures = [Picture]()
    private let baseURL = URL(string: "https://santa-i-wish.firebaseio.com/")
    
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
    
    private func savePictureToServer(_ picture: Picture,completion: @escaping(NSError?) -> Void = {_ in } ) {
        guard let user = Auth.auth().currentUser, let name = user.displayName else { return }
        guard let pixelsURL = baseURL?.appendingPathComponent(name) else { return }
        let request = URLRequest(url: pixelsURL)
        
    }
    
    
}
