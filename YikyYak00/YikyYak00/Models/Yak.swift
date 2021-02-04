//
//  Yak.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import CloudKit

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
    
    var recordID: CKRecord.ID
    
    init(text: String, author: String, timestamp: Date = Date(), score: Int = 0, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.score = score
        self.recordID = recordID
    }
    
} //End of class

extension CKRecord {
    convenience init(yak: Yak) {
        self.init(recordType: YakStrings.recordTypeKey, recordID: yak.recordID)
        
        self.setValuesForKeys([
            YakStrings.textKey : yak.text,
            YakStrings.authorKey : yak.author,
            YakStrings.timestampKey : yak.timestamp,
            YakStrings.scoreKey : yak.score
        ])
    }
} //End of extension

extension Yak {
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[YakStrings.textKey] as? String,
              let author = ckRecord[YakStrings.authorKey] as? String,
              let timestamp = ckRecord[YakStrings.timestampKey] as? Date,
              let score = ckRecord[YakStrings.scoreKey] as? Int
        else {return nil}
        
        self.init(text: text, author: author, timestamp: timestamp, score: score, recordID: ckRecord.recordID)
    }
} //End of extension

extension Yak: Equatable {
    static func == (lhs: Yak, rhs: Yak) -> Bool {
        lhs.recordID == rhs.recordID
    }
} //End of extension
