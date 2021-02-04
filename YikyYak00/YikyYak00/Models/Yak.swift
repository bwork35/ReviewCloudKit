//
//  Yak.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import Foundation

struct YakStrings {
    static let recordTypeKey = "Yak"
    fileprivate static let textKey = "text"
    fileprivate static let authorKey = "author"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let scoreKey = "score"
} //End of struct

class Yak {
    
    let text: String
    let author: String
    let timestamp: Date
    var score: Int
    
    init(text: String, author: String, timestamp: Date = Date(), score: Int) {
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.score = score
    }
    
} //End of class
