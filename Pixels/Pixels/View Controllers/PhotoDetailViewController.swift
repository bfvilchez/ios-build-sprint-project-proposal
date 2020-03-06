//
//  PhotoDetailViewController.swift
//  Pixels
//
//  Created by brian vilchez on 3/6/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    var picture: Picture?
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var photoDetail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let picture = picture else { return }
        lnameLabel.text = picture.name
        photoView.image = UIImage(data: picture.picture!)
        photoDetail.text = picture.pictureDescription
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
