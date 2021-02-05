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
    func createEntry(body: String, title: String, completion: @escaping (Result<String, JournalError>) -> Void) {
        let newEntry = Entry(body: body, title: title)
        let record = CKRecord(entry: newEntry)
        
        privateDB.save(record) { (record, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedEntry = Entry(ckRecord: record)
            else {return completion(.failure(.couldNotUnwrap))}
            
            self.entries.append(savedEntry)
            return completion(.success("Successfully saved an entry."))
        }
    }
    
    func fetchEntries(completion: @escaping (Result<String, JournalError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordType, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            let fetchedEntries = records.compactMap({ Entry(ckRecord: $0) })
            
            let sortedEntries = fetchedEntries.sorted(by: { $0.timestamp < $1.timestamp })
            self.entries = sortedEntries
            return completion(.success("Successfully fetched entries."))
        }
    }
    
    func updateEntry(entry: Entry, completion: @escaping (Result<String, JournalError>) -> Void) {
        let record = CKRecord(entry: entry)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsCompletionBlock = { (records, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = records?.first,
                  let updatedEntry = Entry(ckRecord: record)
            else {return completion(.failure(.couldNotUnwrap))}
            
            return completion(.success("Successfully updated entry with title: \(updatedEntry.title)"))
        }
        privateDB.add(operation)
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Result<String, JournalError>) -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [entry.recordID])
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsCompletionBlock = { (_, recordIDs, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let recordID = recordIDs?.first else {return completion(.failure(.couldNotUnwrap))}
            return completion(.success("Successfully deleted entry with ID: \(recordID.recordName)"))
        }
        privateDB.add(operation)
    }
    
} //End of class
