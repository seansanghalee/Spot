//
//  User.swift
//  Spot
//
//  Created by Sangha Lee on 12/5/20.
//

import Foundation
import Firebase

class User {
    var documentID: String
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var dateOfBirth: String
    var height: String
    var weight: String
    var benchPressMax: String
    var deadliftMax: String
    var squatMax: String
    
    var dictionary: [String: Any] {
        return ["uid": uid, "firstName": firstName, "lastName": lastName, "email": email, "dateOfBirth": dateOfBirth, "height": height, "weight": weight, "benchPressMax": benchPressMax, "deadliftMax": deadliftMax, "squatMax": squatMax]
    }
    
    init(documentID: String, uid: String, firstName: String, lastName: String, email: String, dateOfBirth: String, height: String, weight: String, benchPressMax: String, deadliftMax: String, squatMax: String) {
        self.documentID = documentID
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.benchPressMax = benchPressMax
        self.deadliftMax = deadliftMax
        self.squatMax = squatMax
    }
    
    convenience init() {
        self.init(documentID: "", uid: "", firstName: "", lastName: "", email: "", dateOfBirth: "", height: "", weight: "", benchPressMax: "", deadliftMax: "", squatMax: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let documentID = dictionary["documentID"] as! String? ?? ""
        let uid = dictionary["uid"] as! String? ?? ""
        let firstName = dictionary["firstName"] as! String? ?? ""
        let lastName = dictionary["lastName"] as! String? ?? ""
        let email = dictionary["email"] as! String? ?? ""
        let dateOfBirth = dictionary["dateOfBirth"] as! String? ?? ""
        let height = dictionary["height"] as! String? ?? ""
        let weight = dictionary["weight"] as! String? ?? ""
        let benchPressMax = dictionary["benchPressMax"] as! String? ?? ""
        let deadliftMax = dictionary["deadliftMax"] as! String? ?? ""
        let squatMax = dictionary["squatMax"] as! String? ?? ""
        self.init(documentID: documentID, uid: uid, firstName: firstName, lastName: lastName, email: email, dateOfBirth: dateOfBirth, height: height, weight: weight, benchPressMax: benchPressMax, deadliftMax: deadliftMax, squatMax: squatMax)
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        // create firestore object
        let db = Firestore.firestore()
        
        // get user ID
        guard let uid = Auth.auth().currentUser?.uid else {
            return completion(false)
        }
        self.uid = uid
        
        // create dictionary with data to save
        let dataToSave: [String: Any] = self.dictionary
        
        // if new document
        if self.documentID == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: dataToSave) { (error) in
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
            let ref = db.collection("users").document(self.documentID)
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
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error adding a snapshot listener: \(error!.localizedDescription)")
                return completed()
            }
            
            for document in querySnapshot!.documents {
                let user = User(dictionary: document.data())
                if user.uid == Auth.auth().currentUser?.uid {
                    self.documentID = document.documentID
                    self.uid = user.uid
                    self.firstName = user.firstName
                    self.lastName = user.lastName
                    self.email = user.email
                    self.dateOfBirth = user.dateOfBirth
                    self.height = user.height
                    self.weight = user.weight
                    self.benchPressMax = user.benchPressMax
                    self.deadliftMax = user.deadliftMax
                    self.squatMax = user.squatMax
                    return completed()
                }
            }
            completed()
        }
    }
}
