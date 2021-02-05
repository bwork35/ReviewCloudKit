//
//  JournalError.swift
//  JournalCK00
//
//  Created by Bryan Workman on 2/5/21.
//

import Foundation

enum JournalError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "There was an error unwrapping the entry."
        }
    }
}
