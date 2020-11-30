//
//  SettingsViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title to setting
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
