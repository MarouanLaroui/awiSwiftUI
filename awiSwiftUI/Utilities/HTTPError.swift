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
    case emptyDTO
    case emptyDTOs
    case badRequest
    case badRecoveryOfData
    case unauthorized
    case error(HTTPURLResponse)
    
    var description : String {
        switch self {
        case .badURL: return "Bad URL"
        case .emptyResult: return "Empty Result"
        case .emptyDTOs: return "Empty DTOs"
        case .emptyDTO: return "Empty DTO - mauvaise récupération des données"
        case .error(let httpresponse): return "Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))"
        case .badRequest:
            return "Bad request"
        case .badRecoveryOfData:
            return "bad recovery of data"
        case .unauthorized:
            return "unauthorized request"
        }
    }
}
