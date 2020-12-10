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
    
    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
}
