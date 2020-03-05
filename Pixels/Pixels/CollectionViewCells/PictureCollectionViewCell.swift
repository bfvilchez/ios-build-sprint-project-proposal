//
//  PictureCollectionViewCell.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit
import CoreData
class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var polaroidImage: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
    var picture: Picture? {
        didSet {
            updateViews()
            styleCell()
        }
    }
    
    private func updateViews() {
        guard let picture = picture else { return }
        guard let picData = picture.picture else { return }
        polaroidImage.image = UIImage(data: picData)
        imageNameLabel.text = picture.name
    }
    
    private func styleCell() {
        self.layer.cornerRadius = 10
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}
