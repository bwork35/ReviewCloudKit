//
//  Entry.swift
//  JournalCK00
//
//  Created by Bryan Workman on 1/30/21.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let recordType = "Entry"
}

class Entry {
    var body: String
    var title: String
    var timestamp: Date
    
    init(body: String, title: String, timestamp: Date = Date()) {
        self.body = body
        self.title = title
        self.timestamp = timestamp
    }
} //End of class

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordType)
        
        self.setValuesForKeys([
            EntryConstants.titleKey : entry.title,
            EntryConstants.bodyKey : entry.body,
            EntryConstants.timestampKey : entry.timestamp
        ])
    }
} //End of extension

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String,
              let body = ckRecord[EntryConstants.bodyKey] as? String,
              let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else {return nil}
        
        self.init(body: body, title: title, timestamp: timestamp)
    }
} //End of extension
