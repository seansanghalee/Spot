//
//  Photos.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import Foundation
import Firebase

class Photos {
    
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(user: User, completed: @escaping () -> ()) {
        // check if there are no workouts
        guard user.documentID != "" else {
            return
        }
        
        db.collection("users").document(user.documentID).collection("photos").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return
            }
            
            self.photoArray = []
            
            for document in querySnapshot!.documents {
                let photo = Photo(dictionary: document.data())
                photo.documentID = document.documentID
                self.photoArray.append(photo)
            }
            completed()
        }
    }
    
}
