//
//  WorkoutDetailViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/30/20.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var setTextField: UITextField!
    @IBOutlet weak var repTextField: UITextField!
    
    var session: Session!
    var workout: Workout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if workout == nil {
            workout = Workout()
        }
        
        updateUI()
    }
    
    func updateUI() {
        nameTextField.text = workout.name
        setTextField.text = workout.set
        repTextField.text = workout.rep
    }
    
    func updateFromUI() {
        workout.name = nameTextField.text!
        workout.set = setTextField.text!
        workout.rep = repTextField.text!
    }
    
    func leaveViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUI()
        
        workout.saveData(session: session) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("Unable to save data")
            }
        }
    }
}
