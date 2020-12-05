//
//  AccountViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var benchPressMaxLabel: UILabel!
    @IBOutlet weak var deadliftMaxLabel: UILabel!
    @IBOutlet weak var squatMaxLabel: UILabel!
    @IBOutlet weak var totalMaxLabel: UILabel!
    
    var user: User!
    
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title
        self.navigationController?.navigationBar.topItem?.title = "Account"
        
        user.loadData {
            print("User loaded: \(self.user.uid)")
            self.updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User()
    }
    
    func updateUI() {
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        emailLabel.text = user.email
        dateOfBirthLabel.text = user.dateOfBirth
        heightLabel.text = "\(user.height) cm"
        weightLabel.text = "\(user.weight) kg"
        bmiLabel.text = ""
        benchPressMaxLabel.text = "\(user.benchPressMax) kg"
        deadliftMaxLabel.text = "\(user.deadliftMax) kg"
        squatMaxLabel.text = "\(user.squatMax) kg"
        totalMaxLabel.text = " kg"
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
}
