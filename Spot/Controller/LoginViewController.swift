//
//  LoginViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/27/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide errorLabel
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Validate text fields
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            showError("Please fill in all fields.")
        }
        
        // Sign in the user
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                self.showError("Couldn't sign in")
            } else {
                self.performSegue(withIdentifier: "ShowHome", sender: nil)
            }
        }
        
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}

