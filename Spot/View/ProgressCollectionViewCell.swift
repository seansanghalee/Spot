//
//  ProgressCollectionViewCell.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User!
    var photo: Photo! {
        didSet {
            photo.loadImage(user: user) { (success) in
                if success {
                    self.imageView.image = self.photo.image
                } else {
                    print("Error loading image")
                }
            }
        }
    }
}
