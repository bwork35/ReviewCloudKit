//
//  Entry.swift
//  JournalCK00
//
//  Created by Bryan Workman on 1/30/21.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let recordType = "Entry"
    fileprivate static let titleKey = "title"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestampKey = "timestamp"
}

class Entry {
    var body: String
    var title: String
    var timestamp: Date
    
    let recordID: CKRecord.ID
    
    init(body: String, title: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.body = body
        self.title = title
        self.timestamp = timestamp
        self.recordID = recordID
    }
} //End of class

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordType, recordID: entry.recordID)
        
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
        
        self.init(body: body, title: title, timestamp: timestamp, recordID: ckRecord.recordID)
    }
} //End of extension

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}
