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
    
    var pictureRepresentation: PictureRepresentation? {
        guard let name = name, let photoDescription = pictureDescription, let data = picture else { return nil}
        return PictureRepresentation(imageData: data, name: name, photoDescription: photoDescription)
    }
    
    convenience init(name: String ,picture: Data, pictureDescription: String, context: NSManagedObjectContext) {
        self.init(context:context)
        self.picture = picture
        self.pictureDescription = pictureDescription
        self.name = name
    }
    
    convenience init?(pictureRepresentation: PictureRepresentation, context: NSManagedObjectContext) {
//        guard let name = pictureRepresentation.name,
//            let photoDescription = pictureRepresentation.photoDescription,
//            let data = pictureRepresentation.imageData else {return nil}
        
        self.init(name: pictureRepresentation.name ,picture: pictureRepresentation.imageData, pictureDescription: pictureRepresentation.photoDescription, context: context)
    }
}
