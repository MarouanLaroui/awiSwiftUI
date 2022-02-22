//
//  JSONError.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 19/02/2022.
//

import Foundation

enum JSONError : Error{
    case fileNotFound(String)
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknowned
    
    var description : String {
    switch self {
        case .fileNotFound(let filename): return "File \(filename) not found"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case .JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknowned: return "unknown error"
        }
    }
    
}
