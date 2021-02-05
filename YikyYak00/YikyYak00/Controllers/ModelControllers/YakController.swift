//
//  YakController.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import CloudKit

class YakController {
    
    static let shared = YakController()
    
    
    
    /*
     APP NOT CONNECTED TO CLOUDKIT IN SIGNING & CAPABILITIES
     --------------------------------------------------------
     MOCK DATA BELOW
     
     
    var yakys: [Yak] = {
        let yak1 = Yak(text: "To be or not to be", author: "Hamlet", score: 5)
        let yak2 = Yak(text: "Life's and bitch and then you die.", author: "Anon.", score: 3)
        let yak3 = Yak(text: "I really loved this week :)", author: "no one ever", score: 0)
        let yak4 = Yak(text: "This is the worst thing I've ever seen", author: "Max", score: 500)

        return [yak1, yak2, yak3, yak4]
    }()
    
    */
    
    var yaks: [Yak] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Methods
    func createYak(with text: String, author: String, completion: @escaping (Result<String, YakError>) -> Void) {
        
        let newYak = Yak(text: text, author: author)
        let newYakRecord = CKRecord(yak: newYak)
        
        publicDB.save(newYakRecord) { (record, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedYak = Yak(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            
            self.yaks.append(savedYak)
            return completion(.success("Successfully yikked a Yak!"))
        }
    }
    
    func fetchAllYaks(completion: @escaping (Result<String, YakError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: YakStrings.recordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            let fetchedYaks = records.compactMap({ Yak(ckRecord: $0) })
            
            let sortedYaks = fetchedYaks.sorted(by: { $0.score > $1.score })
            self.yaks = sortedYaks
            
            return completion(.success("Successfully fetched all Yaks!"))
        }
    }
    
    func updateYak(yak: Yak, completion: @escaping (Result<Yak, YakError>) -> Void) {
        
        let record = CKRecord(yak: yak)
        
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
                  let updatedYak = Yak(ckRecord: record)
            else {return completion(.failure(.couldNotUnwrap))}
            
            return completion(.success(updatedYak))
        }
        publicDB.add(operation)
    }
    
    func deleteYak(yak: Yak, completion: @escaping (Result<String, YakError>) -> Void) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [yak.recordID])
        
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
            
            return completion(.success("Successfully deleted Yak with record ID: \(recordID.recordName)"))
        }
        publicDB.add(operation)
    }
    
} //End of class
