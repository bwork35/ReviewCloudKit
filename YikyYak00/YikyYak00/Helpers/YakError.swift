//
//  YakError.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import Foundation

enum YakError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    
}

enum YYError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    case unableToDeleteRecord
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return "There was an error \(error) -- \(error.localizedDescription)"
        case .couldNotUnwrap:
            return "There was an error unwraping a post"
        case .unableToDeleteRecord:
            return "There was an error deleting a record from CloudKit"
        }
    }
}
