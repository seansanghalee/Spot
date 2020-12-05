//
//  NoteDetailViewController.swift
//  Spot
//
//  Created by Sangha Lee on 12/3/20.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet weak var noteTextView: UITextView!
    
    var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        noteTextView.text! = session.note
    }
    
    func updateFromUI() {
        session.note = noteTextView.text ?? ""
    }
    
    func leaveViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUI()
        
        session.saveData { (success) in
            if success {
                self.leaveViewController()
            }
        }
    }
}
