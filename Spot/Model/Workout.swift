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
    var set: Int = 0
    var rep: Int = 0
    var documentID: String = ""
    
    var dictionary: [String: Any] {
        return ["name": name, "set": set, "rep": rep, "documentID": documentID]
    }
    
    init(name: String, set: Int, rep: Int, documentID: String) {
        self.name = name
        self.set = set
        self.rep = rep
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(name: "", set: 0, rep: 0, documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let set = dictionary["set"] as! Int? ?? 0
        let rep = dictionary["rep"] as! Int? ?? 0
        let documentID = dictionary["documentID"] as! String? ?? ""
        self.init(name: name, set: set, rep: rep, documentID: documentID)
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
