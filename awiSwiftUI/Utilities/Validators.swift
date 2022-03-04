//
//  Validators.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import Foundation

struct Validators{

    static func isMailValid(mail : String) -> Bool {
        return String.matchRegex(
            str: mail,
            regexStr: #"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"#
        )
    }
    
    
    static func isPhoneValid(phone : String) -> Bool{
        return String.matchRegex(
            str: phone,
            regexStr: #"^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$"#
        )
    }
    
    static func isValidAge(age : Int) -> Bool{
        return age>0 && age < 120
    }
    
}
