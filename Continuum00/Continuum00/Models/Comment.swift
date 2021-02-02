//
//  Comment.swift
//  Continuum00
//
//  Created by Bryan Workman on 2/1/21.
//

import CloudKit

class Comment {
    
    var text: String
    var timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date = Date(), post: Post) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
    
} //End of class
