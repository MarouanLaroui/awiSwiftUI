//
//  User.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class User{

    var id : Int?
    var name : String
    var last_name : String
    var mail : String
    var phone : String
    var birthdate : String
    var isAdmin : Bool
    
    //var access_token : String?
   
    
    internal init(id: Int? = nil, name: String, last_name: String, mail: String, phone : String, isAdmin: Bool, birthdate: String) {
        self.id = id
        self.name = name
        self.last_name = last_name
        self.mail = mail
        self.phone = phone
        self.isAdmin = isAdmin
        self.birthdate = birthdate
    }
    

}

extension User{
    static var users = [
        User(id: 1, name: "Marouan", last_name: "Laroui", mail: "marouan.laroui@etu.umontpellier", phone: "0658003255", isAdmin: true, birthdate: "22/03/022"),
        User(id: 2, name: "Ophélie", last_name: "Amarine", mail: "ophelie.amarine@etu.umontpellier", phone: "0658003255", isAdmin: true, birthdate :"22/03/022")
    ]
}

protocol UserDelegate{
    
    func userChange(id : Int)
    func userChange(firstName : String)
    func userChange(lastName : Int)
    func userChange(email : Int)
    func userChange(isAdmin : Int)
    func userChange(birthDate : Int)
    
}
