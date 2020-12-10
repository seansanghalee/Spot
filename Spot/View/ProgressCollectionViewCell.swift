//
//  ProgressCollectionViewCell.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import UIKit
import SDWebImage

class ProgressCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User!
    var photo: Photo! {
        didSet {
            
            if let url = URL(string: self.photo.photoURL) {
                self.imageView.sd_imageTransition = .fade
                self.imageView.sd_imageTransition?.duration = 0.2
                self.imageView.sd_setImage(with: url)
                
            } else {
                print("URL didn't work")
            }
//            photo.loadImage(user: user) { (success) in
//                if success {
//                    self.imageView.image = self.photo.image
//                } else {
//                    print("Error loading image")
//                }
//            }
        }
    }
}
