//
//  Post.swift
//  Continuum00
//
//  Created by Bryan Workman on 2/1/21.
//

import CloudKit
import UIKit

//Posts Comment ?

struct PostStrings {
    static let typeKey = "Post"
    static let captionKey = "caption"
    static let timestampKey = "timestamp"
    static let commentsKey = "comments"
//    static let photoKey = "photo"
}//End of struct

class Post {
    var caption: String
    var timestamp: Date
    var comments: [Comment]
    let recordID: CKRecord.ID
//    var photoData: Data?
//
//    var photo: UIImage? {
//        get {
//            guard let photoData = photoData else {return nil}
//            return UIImage(data: photoData)
//        } set {
//            photoData = newValue?.jpegData(compressionQuality: 0.5)
//        }
//    }
    
    init(caption: String, timestamp: Date = Date(), comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)/*, photo: UIImage?*/) {
        self.caption = caption
        self.timestamp = timestamp
        self.comments = comments
        self.recordID = recordID
//        self.photo = photo
    }
} //End of class


extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: PostStrings.typeKey, recordID: post.recordID)
        setValuesForKeys([
            PostStrings.captionKey : post.caption,
            PostStrings.timestampKey : post.timestamp
            
        ])
    }
} //End of extension


extension Post {
    convenience init?(ckRecord: CKRecord) {
        guard let caption = ckRecord[PostStrings.captionKey] as? String,
              let timestamp = ckRecord[PostStrings.timestampKey] as? Date else {return nil}
        
        self.init(caption: caption, timestamp: timestamp, comments: [], recordID: ckRecord.recordID)
    }
} //End of extension


