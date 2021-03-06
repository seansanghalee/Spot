//
//  ProgressDetailViewController.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import UIKit
import SDWebImage

class ProgressDetailViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var dateFormatter = DateFormatter()
    
    var user: User!
    var photo: Photo!
    var isAdding: Bool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAdding {
            deleteButton.isHidden = true;
        } else {
            saveButton.isEnabled = false
        }
        
        if photo == nil {
            photo = Photo()
        }
        
        updateUI()
    }
    
    func updateUI() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateLabel.text = "\(dateFormatter.string(from: photo.date))"
        
        guard let url = URL(string: photo.photoURL) else {
            print("URL didn't work")
            imageView.image = photo.image
            return
        }
        
        imageView.sd_imageTransition = .fade
        imageView.sd_imageTransition?.duration = 0.5
        imageView.sd_setImage(with: url)
    }
    
    func leaveViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        photo.saveData(user: user) { (success) in
            if success {
                self.leaveViewController()
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
}
