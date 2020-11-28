//
//  AccountViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Account"
    }

}
