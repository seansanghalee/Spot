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
    var session: Session!
    var workouts: Workouts!
    
    override func viewWillAppear(_ animated: Bool) {
        // set up navigation controller title
        self.navigationController?.navigationBar.topItem?.title = "Today"
        
        // load a session from Firebase. If today's session doesn't exist, create a new session
        session = Session()
        session.loadData {
            print("Session loaded: \(self.session.documentID)")
            self.updateUI()
        }
        
        // load workouts from Firebase using session. If workouts don't exist, create new workouts.
        workouts = Workouts()
        workouts.loadData(session: session) {
            print("Workouts loaded: \(self.workouts.workoutArray)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearUI()
        
        // set up table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        session.saveData { (success) in
            if success {
                print("Session saved: \(self.session.documentID)")
            } else {
                print("Error saving data")
            }
        }
        
        tableView.reloadData()
    }
    
    func clearUI() {
        dateLabel.text = ""
        noteLabel.text = ""
    }
    
    func updateUI() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateLabel.text = "\(dateFormatter.string(from: session.date))"
        noteLabel.text = session.note
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // a table view cell is pressed
        switch segue.identifier ?? "" {
        
        case "EditWorkout":
            let destination = segue.destination as! WorkoutDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.workout = workouts.workoutArray[index]
            destination.session = session
            
        case "AddWorkout":
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
            
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! WorkoutDetailViewController
            destination.session = session
            
        case "EditNote":
            let destination = segue.destination as! NoteDetailViewController
            destination.session = session
            
            
        default:
            print("Could not find segue identifier: \(segue.identifier!)")
        }
    }
    
    @IBAction func unwindFromWorkoutDetailViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! WorkoutDetailViewController
        
        // set workout object to retrieve
        if let indexPath = tableView.indexPathForSelectedRow {
            workouts.workoutArray[indexPath.row] = source.workout!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else {
            let newIndexPath = IndexPath(row: workouts.workoutArray.count, section: 0)
            workouts.workoutArray.append(source.workout!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        print(workouts.workoutArray)
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        // load previous session
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        // load next session
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "AddWorkout", sender: nil)
    }
    
    @IBAction func noteButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "EditNote", sender: nil)
    }
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkoutTableViewCell
        cell.nameLabel.text = "\(workouts.workoutArray[indexPath.row].name)"
        cell.setLabel.text = "\(workouts.workoutArray[indexPath.row].set)"
        cell.repLabel.text = "\(workouts.workoutArray[indexPath.row].rep)"
        return cell
    }
    
}
