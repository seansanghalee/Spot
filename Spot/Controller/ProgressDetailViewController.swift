//
//  ProgressDetailViewController.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import UIKit

class ProgressDetailViewController: UIViewController {
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
        imageView.image = photo.image
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
