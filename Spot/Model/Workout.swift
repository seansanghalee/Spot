//
//  Workout.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import Foundation
import Firebase

class Workout {
    var name: String = ""
    var set: String = ""
    var rep: String = ""
    var documentID: String = ""
    
    var dictionary: [String: Any] {
        return ["name": name, "set": set, "rep": rep]
    }
    
    init(name: String, set: String, rep: String) {
        self.name = name
        self.set = set
        self.rep = rep
        self.documentID = ""
    }
    
    convenience init() {
        self.init(name: "", set: "", rep: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let set = dictionary["set"] as! String? ?? ""
        let rep = dictionary["rep"] as! String? ?? ""
        self.init(name: name, set: set, rep: rep)
    }
    
    func saveData(session: Session, completion: @escaping (Bool) ->()) {
        let db = Firestore.firestore()
        
        let dataToSave: [String: Any] = self.dictionary
        
        if self.documentID == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("sessions").document(session.documentID).collection("workouts").addDocument(data: dataToSave) { (error) in
                guard error == nil else {
                    return completion(false)
                }
                self.documentID = ref!.documentID
                completion(true)
            }
        }
        else {
            let ref = db.collection("sessions").document(session.documentID).collection("workouts").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    return completion(false)
                }
                completion(true)
            }
        }
    }
}
