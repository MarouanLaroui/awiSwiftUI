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
}
