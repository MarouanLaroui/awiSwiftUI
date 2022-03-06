//
//  User.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation

class User : Identifiable, ObservableObject{

    var delegate : UserDelegate?
    
    var id : Int?{
        didSet{
            self.delegate?.userChange(id: self.id)
        }
    }

    var name : String{
        didSet{
            print("didSet User")
            print(self.name)
            self.delegate?.userChange(name: self.name)
        }
    }
    var last_name : String{
        didSet{
            self.delegate?.userChange(last_name: self.last_name)
        }
    }
    var mail : String{
        didSet{
            self.delegate?.userChange(mail: self.mail)
        }
    }
    var phone : String{
        didSet{
            self.delegate?.userChange(phone: self.phone)
        }
    }
    var birthdate : String{
        didSet{
            self.delegate?.userChange(birthdate: self.birthdate)
        }
    }
    var isAdmin : Bool{
        didSet{
            self.delegate?.userChange(isAdmin: self.isAdmin)
        }
    }
    
    @Published var access_token : Bool?
   
    
    internal init(id: Int? = nil, name: String, last_name: String, mail: String, phone : String, isAdmin: Bool, birthdate: String) {
        self.id = id
        self.name = name
        self.last_name = last_name
        self.mail = mail
        self.phone = phone
        self.isAdmin = isAdmin
        self.birthdate = birthdate
    }
    
    
    
    
    
    var isValid : Bool {
        return self.name.count > 0 && self.last_name.count > 0 && Validators.isMailValid(mail: self.mail)
        //&& Validators.isPhoneValid(phone: self.phone) && Validators.isDateValid(date: self.birthdate)
    }
    

}

extension User{
    static var users = [
        User(id: 1, name: "Marouan", last_name: "Laroui", mail: "marouan.laroui@etu.umontpellier", phone: "0658003255", isAdmin: true, birthdate: "22/03/022"),
        User(id: 2, name: "Ophélie", last_name: "Amarine", mail: "ophelie.amarine@etu.umontpellier", phone: "0658003255", isAdmin: true, birthdate :"22/03/022")
    ]
}

protocol UserDelegate{
    
    func userChange(id : Int?)
    func userChange(name : String)
    func userChange(last_name : String)
    func userChange(mail : String)
    func userChange(phone : String)
    func userChange(isAdmin : Bool)
    func userChange(birthdate : String)
    
}
