//
//  TodayViewController.swift
//  Spot
//
//  Created by Sangha Lee on 11/27/20.
//

import UIKit
import Firebase

class TodayViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noteLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    var session = Session()
    
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title
        self.navigationController?.navigationBar.topItem?.title = "Today"
        
        // loads session data from Firebase
        session.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up table view
        tableView.delegate = self
        tableView.dataSource = self
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        session.date = Date()
        session.workouts = [Workout(name: "Bench Press", set: 4, rep: 12), Workout(name: "Incline Press", set: 4, rep: 12), Workout(name: "Dips", set: 4, rep: 15), Workout(name: "Chest Fly", set: 4, rep: 12)]
        session.note = "Feeling great."
        
        dateLabel.text = "\(dateFormatter.string(from: session.date))"
        noteLabel.text = session.note
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWorkoutDetail" {
            let destination = segue.destination as! WorkoutDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.workout = session.workouts[index]
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
    }
    @IBAction func rightButtonPressed(_ sender: UIButton) {
    }
    @IBAction func plusButtonPressed(_ sender: UIButton) {
    }
    @IBAction func noteButtonPressed(_ sender: UIButton) {
    }
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkoutTableViewCell
        cell.nameLabel.text = "\(session.workouts[indexPath.row].name)"
        cell.setLabel.text = "\(session.workouts[indexPath.row].set)"
        cell.repLabel.text = "\(session.workouts[indexPath.row].rep)"
        return cell
    }
    
}
