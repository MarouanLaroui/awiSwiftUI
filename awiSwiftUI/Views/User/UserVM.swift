//
//  UserVM.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import Foundation
import SwiftUI
import Combine

class UserVM : UserDelegate, ObservableObject, Subscriber{
    
    var copy : User
    var model : User
    
    @Published var id : Int?
    @Published var name : String
    @Published var last_name : String
    @Published var mail : String
    @Published var phone : String
    @Published var birthdate : Date
    @Published var isAdmin : Bool
    
    
    var isDefaultName : Bool = true
    var isDefaultLast_name : Bool = true
    var isDefaultMail : Bool = true
    var isDefaultPhone : Bool = true
    var isDefaultbirthdate : Bool = true
    
    init(model : User){
        
        self.model = model
        self.copy = User(id: model.id, name: model.name, last_name: model.last_name, mail: model.mail, phone: model.phone, isAdmin: model.isAdmin, birthdate: model.birthdate)
        
        self.id = self.model.id
        self.name = self.model.name
        self.last_name = self.model.last_name
        self.mail = self.model.mail
        self.phone = self.model.phone
        //Gérer après
        self.birthdate = Date()
        self.isAdmin = self.model.isAdmin
     
        self.copy.delegate = self
    }
    
    func userChange(id: Int?) {
        self.id = id
    }
    
    func userChange(name: String) {
        self.name = name
    }
    
    func userChange(last_name: String) {
        self.last_name = last_name
    }
    
    func userChange(mail: String) {
        self.mail = mail
    }
    
    func userChange(phone: String) {
        self.phone = phone
    }
    
    func userChange(isAdmin: Bool) {
        self.isAdmin = isAdmin
    }
    
    /*Gérer plus tard*/
    func userChange(birthdate: String) {
        self.birthdate = Date()
    }
    
    typealias Input = IntentUserState
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentUserState) -> Subscribers.Demand {
        switch(input){
            
        case .ready:
            break
            
        case .nameChanging(name: let name):
            self.copy.name = name
            self.isDefaultName = false
            
        case .lastNameChanging(last_name: let last_name):
            self.copy.last_name = last_name
            self.isDefaultName = false
            
        case .mailChanging(mail: let mail):
            self.copy.mail = mail
            self.isDefaultMail = false
            
        case .phoneChanging(phone: let phone):
            self.copy.phone = phone
            self.isDefaultPhone = false
            
        case .isAdminChanging(isAdmin: let isAdmin):
            self.copy.isAdmin = isAdmin
            
        case .birthdateChanging(birthdate: let birthdate):
            self.copy.birthdate = birthdate
            self.isDefaultbirthdate = false
            
        case .validateChange:
            self.model.id = self.copy.id
            self.model.name = self.copy.name
            self.model.last_name = self.copy .last_name
            self.model.phone = self.copy.phone
            self.model.birthdate = self.copy.birthdate
            self.model.isAdmin = self.copy.isAdmin
            self.model.mail = self.copy.mail
            break
        case .userCreation(user: let user):
            
            break
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    var isValid : Bool{
        return self.copy.isValid
    }
    
    var nameErrorMsg : String{
        if(self.isDefaultName || self.copy.name.count > 0  ){
            return ""
        }
        return "Ce champs est obligatoire"
    }
    
    var last_nameErrorMsg : String{
        if(self.copy.last_name.count > 0 || self.isDefaultLast_name){
            return ""
        }
        return "Ce champs est obligatoire"
    }
    
    
    var birthdateErrorMsg : String {
        if(Validators.isDateValid(date: self.copy.birthdate) || self.isDefaultbirthdate){
            return ""
        }
        return "Format de date différente de MM/DD/YYYY"
    }
    
    var phoneErrorMsg : String {
        if(Validators.isPhoneValid(phone: self.copy.phone) || self.isDefaultPhone){
            return ""
        }
        return "Numéro de téléphone invalide"
    }
    
    var mailErrorMsg : String{
        if(Validators.isMailValid(mail: self.copy.mail) || self.isDefaultMail){
            
            return ""
        }
        return "Format de mail invalide"
    }
    
    /*TODO : see why not refreshing*/
    func reloadErrorMsg(){
       
        self.isDefaultbirthdate = false
        self.isDefaultMail = false
        self.isDefaultName = false
        self.isDefaultLast_name = false
        self.isDefaultPhone = false
        
    }
    
    
}
