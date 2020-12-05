//
//  AccountViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class AccountViewController: UIViewController {
    
    var user: User!
    
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title
        self.navigationController?.navigationBar.topItem?.title = "Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User()
        }
    }
    
}
