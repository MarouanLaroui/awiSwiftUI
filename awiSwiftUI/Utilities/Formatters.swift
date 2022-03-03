//
//  Formatters.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import Foundation

class Formatters{
    
    static let decimal : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    static let int : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()
}
