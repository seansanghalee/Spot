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
        
        if workout.set == 0 {
            setTextField.text = ""
        } else {
            setTextField.text = "\(workout.set)"
        }
        
        if workout.rep == 0 {
            repTextField.text = ""
        } else {
            repTextField.text = "\(workout.rep)"
        }
    }
    
    func updateFromUI() {
        workout.name = nameTextField.text!
        workout.set = Int(setTextField.text!)!
        workout.rep = Int(repTextField.text!)!
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUI()
        workout.saveData(session: session) { (success) in
            if success {
                self.leaveViewController()
            } else {
                // save failed
            }
        }
    }
}
