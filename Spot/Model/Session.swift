//
//  Workouts.swift
//  Spot
//
//  Created by Sangha Lee on 11/28/20.
//

import Foundation
import Firebase

class Session {
    var date: Date
    var note: String
    var userID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        let timeIntervalDate = date.timeIntervalSince1970
        return ["date": timeIntervalDate, "note": note, "userID": userID]
    }
    
    init(date: Date, note: String, userID: String, documentID: String) {
        self.date = date
        self.note = note
        self.userID = userID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(date: Date(), note: "", userID: Auth.auth().currentUser!.uid, documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        let note = dictionary["note"] as! String? ?? ""
        let userID = dictionary["userID"] as! String? ?? ""
        let documentID = dictionary["documentID"] as! String? ?? ""
        self.init(date: date, note: note, userID: userID, documentID: documentID)
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        // create firestore object
        let db = Firestore.firestore()
        
        // get user ID
        guard let userID = Auth.auth().currentUser?.uid else {
            return completion(false)
        }
        self.userID = userID
        
        // create dictionary with data to save
        let dataToSave: [String: Any] = self.dictionary
        
        // if new document
        if self.documentID == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("sessions").addDocument(data: dataToSave) { (error) in
                guard error == nil else {
                    print("Error adding document: \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                completion(true)
            }
        }
        
        // if existing document
        else {
            let ref = db.collection("sessions").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("Error updating document: \(error!.localizedDescription)")
                    return completion(false)
                }
                completion(true)
            }
        }
    }
    
    func loadData(completed: @escaping () -> ()) {
        // create firestore object
        let db = Firestore.firestore()
        
        // check "sessions" collection in firestore database
        db.collection("sessions").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error adding a snapshot listener: \(error!.localizedDescription)")
                return completed()
            }
            
            for document in querySnapshot!.documents {
                let session = Session(dictionary: document.data())
                if session.userID == Auth.auth().currentUser?.uid && self.isSameDay(date1: session.date, date2: Date()) {
                    self.date = session.date
                    self.note = session.note
                    self.userID = session.userID
                    self.documentID = document.documentID
                    return completed()
                }
            }
            completed()
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.isDate(date1, equalTo: date2, toGranularity: .day)
    }
}
