//
//  PostController.swift
//  Continuum00
//
//  Created by Bryan Workman on 2/2/21.
//

import CloudKit
import UIKit

class PostController {
    
    static let shared = PostController()
    
    var posts: [Post] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Methods
    func createPostWith(photo: UIImage, caption: String, completion: @escaping (Result<String, PostError>) -> Void) {
        
        
//        publicDB.save(<#T##record: CKRecord##CKRecord#>, completionHandler: <#T##(CKRecord?, Error?) -> Void#>)
        
    }
    
    func fetchAllPosts(completion: @escaping (Result<String, PostError>) -> Void) {
        
        
//        publicDB.perform(<#T##query: CKQuery##CKQuery#>, inZoneWith: <#T##CKRecordZone.ID?#>, completionHandler: <#T##([CKRecord]?, Error?) -> Void#>)
        
    }
    
    func update(post: Post, completion: @escaping (Result<String, PostError>) -> Void) {
        
        

        
        
//        publicDB.add(<#T##operation: CKDatabaseOperation##CKDatabaseOperation#>)
    }
    
    func delete(post: Post, completion: @escaping (Result<String, PostError>) -> Void) {
        
        
        
//        publicDB.add(<#T##operation: CKDatabaseOperation##CKDatabaseOperation#>)
    }
    
    
    
} //End of class
