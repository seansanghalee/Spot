//
//  Workouts.swift
//  Spot
//
//  Created by Sangha Lee on 11/30/20.
//

import Foundation
import Firebase

class Workouts {
    var workoutArray: [Workout] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(session: Session, completed: @escaping () -> ()) {
        // check if there are no workouts
        guard session.documentID != "" else {
            return
        }
        
        db.collection("sessions").document(session.documentID).collection("workouts").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return
            }
            
            self.workoutArray = []
            
            for document in querySnapshot!.documents {
                let workout = Workout(dictionary: document.data())
                workout.documentID = document.documentID
                self.workoutArray.append(workout)
            }
            completed()
        }
    }
}
