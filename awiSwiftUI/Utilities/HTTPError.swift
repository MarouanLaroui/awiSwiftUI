//
//  HTTPError.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 19/02/2022.
//

import Foundation

enum HTTPError : Error{
    case badURL
    case emptyResult
    case emptyDTOs
}
