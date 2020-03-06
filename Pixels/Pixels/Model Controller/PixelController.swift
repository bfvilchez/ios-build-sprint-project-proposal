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
import FirebaseStorage

@objc class PixelController: NSObject {
    static var token:String?
    private(set) var pictures = [Picture]()
    private let baseURL = URL(string: "https://santa-i-wish.firebaseio.com")
    
    func createImage(WithName name: String, image: UIImage, pictureDescription:String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let image = image.jpegData(compressionQuality: 60) else { return }
        let picture = Picture(name: name, picture: image, pictureDescription: pictureDescription, context: context)
        pictures.append(picture)
        self.savePictureToServer(picture)
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
    
    func deleteCoreData() {
        let fetchRequest:NSFetchRequest<Picture> = NSFetchRequest(entityName: "Picture")
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try CoreDataStack.shared.mainContext.execute(deleteBatch)
        } catch {
            NSLog("failed to delete objects")
        }
    }
    
    private func savePictureToServer(_ picture: Picture,completion: @escaping(NSError?) -> Void = {_ in } ) {
        guard let uuid = Auth.auth().currentUser?.uid else { return }
        guard let pixelsURL = baseURL?.appendingPathComponent(uuid).appendingPathComponent("images").appendingPathComponent(UUID().uuidString).appendingPathExtension("json") else { return }
        print(pixelsURL)
        var request = URLRequest(url: pixelsURL)
        request.httpMethod = "PUT"
        do {
            let encoder = JSONEncoder()
            let pictureData = try encoder.encode(picture.pictureRepresentation)
            request.httpBody = pictureData
        } catch let error as NSError {
            NSLog("failed to encode data: \(error)")
            completion(error)
        }
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error as NSError? {
                NSLog("failed to put picture on dataBase: \(error)")
                completion(error)
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("\(response.statusCode)")
            }
            completion(nil)
        }.resume()
    }
    
    func fetchImagesFromServer(completion: @escaping(NSError?) -> Void = {_ in }) {
        guard let uuid = Auth.auth().currentUser?.uid else { return }
        guard let pixelsURL = baseURL?.appendingPathComponent(uuid).appendingPathComponent("images").appendingPathExtension("json") else { return }
        print(pixelsURL)
        var request = URLRequest(url: pixelsURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { ( data, response, error) in
            if let error = error as NSError? {
                NSLog("failed to put picture on dataBase: \(error)")
                completion(error)
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("\(response.statusCode)")
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let pictures = try decoder.decode([String: PictureRepresentation].self, from: data).map({ $0.value})
                print(pictures)
                self.addPicturesToCoreData(pictures)
            } catch let error as NSError {
                NSLog("failed to encode data: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    private func addPicturesToCoreData(_ picturesRepresentations: [PictureRepresentation] ) {
        for representation in picturesRepresentations {
            _ = Picture(pictureRepresentation: representation, context: CoreDataStack.shared.mainContext)
            CoreDataStack.shared.mainContext.saveChanges()
        }
        
    }
}
