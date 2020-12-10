//
//  Photo.swift
//  Spot
//
//  Created by Sangha Lee on 12/9/20.
//

import UIKit
import Firebase

class Photo {
    var image: UIImage
    var date: Date
    var photoURL: String
    var documentID: String
    
    var dictionary: [String: Any] {
        let timeIntervalDate = date.timeIntervalSince1970
        return ["date": timeIntervalDate, "photoURL": photoURL]
    }
    
    init(image: UIImage, date: Date, photoURL: String, documentID: String) {
        self.image = image
        self.date = date
        self.photoURL = photoURL
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(image: UIImage(), date: Date(), photoURL: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        
        self.init(image: UIImage(), date: date, photoURL: photoURL, documentID: "")
    }
    
    func saveData(user: User, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        
        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
            print("Error coverting image")
            return
        }
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        if documentID == "" {
            documentID = UUID().uuidString
        }
        
        let storageRef = storage.reference().child(user.documentID).child(documentID)
        
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetaData) { (metadata, error) in
            if let error = error {
                print("Error uploading photo: \(error.localizedDescription)")
            }
        }
        
        uploadTask.observe(.success) { (snapshot) in
            print("Upload successful")
            
            // save to photos collection in user document
            let dataToSave: [String: Any] = self.dictionary
            let ref = db.collection("users").document(user.documentID).collection("photos").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    return completion(false)
                }
                completion(true)
            }
            
            completion(true)
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print("Error upload task: \(error.localizedDescription)")
            }
            completion(false)
        }
    }
    
    func loadImage(user: User, completion: @escaping (Bool) -> ()) {
        guard user.documentID != "" else {
            print("Error passing user's document ID")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference().child(user.documentID).child(documentID)
        storageRef.getData(maxSize: 25 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error reading data: \(error.localizedDescription)")
                return completion(false)
            } else {
                self.image = UIImage(data: data!) ?? UIImage()
                return completion(true)
            }
        }
    }
    
}
