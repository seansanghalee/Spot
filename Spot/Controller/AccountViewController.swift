//
//  AccountViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var benchPressMaxTextField: UITextField!
    @IBOutlet weak var deadliftMaxTextField: UITextField!
    @IBOutlet weak var squatTextField: UITextField!
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
        addPhotoButton.isHidden = true
        
        nameTextField.text = "\(user.firstName) \(user.lastName)"
        emailTextField.text = user.email
        dateOfBirthTextField.text = user.dateOfBirth
        
        heightTextField.text = user.height
        weightTextField.text = user.weight
        if (user.height == "" || user.weight == "") {
            bmiLabel.text = ""
        } else {
            let heightInDouble = Double(user.height)! / 100
            let weightInDouble = Double(user.weight)
            let bmi = weightInDouble! / pow(heightInDouble, 2)
            bmiLabel.text = String(format: "%.2f", bmi)
        }
        
        benchPressMaxTextField.text = user.benchPressMax
        deadliftMaxTextField.text = user.deadliftMax
        squatTextField.text = user.squatMax
        
        var benchPressMaxInDouble: Double!
        var deadliftMaxInDouble: Double!
        var squatMaxInDouble: Double!
        
        if user.benchPressMax == "" {
            benchPressMaxInDouble = 0.0
        } else {
            benchPressMaxInDouble = Double(user.benchPressMax)
        }
        
        if user.deadliftMax == "" {
            deadliftMaxInDouble = 0.0
        } else {
            deadliftMaxInDouble = Double(user.deadliftMax)
        }
        
        if user.squatMax == "" {
            squatMaxInDouble = 0.0
        } else {
            squatMaxInDouble = Double(user.squatMax)
        }
        
        let total = benchPressMaxInDouble + deadliftMaxInDouble + squatMaxInDouble
        if total == 0.0 {
            totalMaxLabel.text = ""
        } else { 
            totalMaxLabel.text = "\(total) kg"
        }
        
    }
    
    func updateFromUI() {
        user.dateOfBirth = dateOfBirthTextField.text!
        user.height = heightTextField.text!
        user.weight = weightTextField.text!
        user.benchPressMax = benchPressMaxTextField.text!
        user.deadliftMax = deadliftMaxTextField.text!
        user.squatMax = squatTextField.text!
        
        user.saveData { (success) in
            if success {
                print("Account updated")
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        if editButton.titleLabel?.text == "Edit" {
            
            editButton.setTitle("Done", for: .normal)
            addPhotoButton.isHidden = false
            dateOfBirthTextField.borderStyle = .roundedRect
            dateOfBirthTextField.isUserInteractionEnabled = true
            heightTextField.borderStyle = .roundedRect
            heightTextField.isUserInteractionEnabled = true
            weightTextField.borderStyle = .roundedRect
            weightTextField.isUserInteractionEnabled = true
            benchPressMaxTextField.borderStyle = .roundedRect
            benchPressMaxTextField.isUserInteractionEnabled = true
            deadliftMaxTextField.borderStyle = .roundedRect
            deadliftMaxTextField.isUserInteractionEnabled = true
            squatTextField.borderStyle = .roundedRect
            squatTextField.isUserInteractionEnabled = true
            
        } else {
            updateFromUI()
            
            editButton.setTitle("Edit", for: .normal)
            addPhotoButton.isHidden = true
            dateOfBirthTextField.borderStyle = .none
            dateOfBirthTextField.isUserInteractionEnabled = false
            heightTextField.borderStyle = .none
            heightTextField.isUserInteractionEnabled = false
            weightTextField.borderStyle = .none
            weightTextField.isUserInteractionEnabled = false
            benchPressMaxTextField.borderStyle = .none
            benchPressMaxTextField.isUserInteractionEnabled = false
            deadliftMaxTextField.borderStyle = .none
            deadliftMaxTextField.isUserInteractionEnabled = false
            squatTextField.borderStyle = .none
            squatTextField.isUserInteractionEnabled = false
        }
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
    }
}
