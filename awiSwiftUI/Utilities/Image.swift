//
//  Image.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import Foundation

struct ImageHelper{
    static func randomPic()->String{
        let random = Int.random(in: 1...7)
        
        switch(random){
        case 1 :
            return "buratta"
        case 2:
            return "cabillaud"
        case 3:
            return "canette"
        case 4:
            return "pappardelle"
        case 5:
            return "poulet-thai"
        case 6:
            return "rigatoni"
        case 7:
            return "dahl"
        default:
            return ""
        }
    
        
    }
}
