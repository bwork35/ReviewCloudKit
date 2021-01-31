//
//  EntryController.swift
//  JournalCK00
//
//  Created by Bryan Workman on 1/30/21.
//

import Foundation
import CloudKit

class EntryController {
    
    //MARK: - Properties
    var entries: [Entry] = []
    static let shared = EntryController()
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK: - CRUD Functions
    func createEntry() {
        
    }
    
    func fetchEntries() {
        
    }
    
    func updateEntry() {
        
    }
    
    func deleteEntry() {
        
    }
    
} //End of class
