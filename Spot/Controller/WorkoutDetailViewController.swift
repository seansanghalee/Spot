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
    
    var workout: Workout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = workout.name
        setTextField.text = "\(workout.set)"
        repTextField.text = "\(workout.rep)"
    }

}
