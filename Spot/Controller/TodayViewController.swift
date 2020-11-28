//
//  TodayViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/27/20.
//

import UIKit

class TodayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Today"
    }
}
