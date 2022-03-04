//
//  DateExtension.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import Foundation

extension Date{
    static func toString(date : Date)->String{
        // Create Date
        let date = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
}
