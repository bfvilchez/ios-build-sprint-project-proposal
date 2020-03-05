//
//  MemoriesViewController.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit
import CoreData

class MemoriesViewController: UIViewController, NSFetchedResultsControllerDelegate  {
    
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private var pixelController = PixelController()
    var user:User?
    
    var fetchResultsController: NSFetchedResultsController<Picture> {
        
        let fetchRequest: NSFetchRequest<Picture> = Picture.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let moc = CoreDataStack.shared.mainContext
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        return fetchResultsController
    }
    
    //MARK: lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: - actions
    @IBAction func AddMemoryButton(_ sender: UIButton) {
        guard let addMemoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMemoryVC") as? AddMemoryViewController else { return }
        addMemoryVC.modalPresentationStyle = .fullScreen
        addMemoryVC.pixelController = pixelController
        self.present(addMemoryVC, animated: true, completion: nil)
        
    }
    
}

extension MemoriesViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 354)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCollectionViewCell else { return UICollectionViewCell()}
        let picture = fetchResultsController.object(at: indexPath)
        cell.picture = picture
        return cell
    }
    
}

extension MemoriesViewController {

}
