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
}
