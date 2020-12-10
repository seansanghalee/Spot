//
//  SettingsViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var settings: [Setting] = [Setting(title: "Dark Mode", bool: false),
                               Setting(title: "Use Metric", bool: true),
                               Setting(title: "Display BMI", bool: true),
                               Setting(title: "Track Big Three", bool: true)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title to setting
        self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingsTableViewCell
        cell.settingLabel.text = settings[indexPath.row].title
        return cell
    }
    
    
}
