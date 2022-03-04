//
//  StringExtension.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import Foundation

extension String{
    
    static func matchRegex(str : String, regexStr : String)->Bool{
        let regex = NSRegularExpression(regexStr)
        return regex.matches(str)
    }
}
