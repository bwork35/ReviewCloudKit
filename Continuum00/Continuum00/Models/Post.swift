//
//  Post.swift
//  Continuum00
//
//  Created by Bryan Workman on 2/1/21.
//

import CloudKit
import UIKit

class Post {
    var caption: String
    var timestamp: Date
    var comments: [Comment]
    var photoData: Data?
    var photo: UIImage? {
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(caption: String, timestamp: Date = Date(), comments: [Comment] = [], photo: UIImage?) {
        self.caption = caption
        self.timestamp = timestamp
        self.comments = comments
        self.photo = photo
    }
} //End of class

