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
    
    
    private var model : User
    
    @Published var id : Int?
    @Published var name : String
    @Published var last_name : String
    @Published var mail : String
    @Published var phone : String
    @Published var birthdate : Date
    @Published var isAdmin : Bool
    
    init(model : User){
        
        self.id = model.id
        self.name = model.name
        self.last_name = model.last_name
        self.mail = model.mail
        self.phone = model.phone
        //Gérer après
        self.birthdate = Date()
        self.isAdmin = model.isAdmin
        
        self.model = model
        self.model.delegate = self
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
            self.model.name = name
        case .lastNameChanging(last_name: let last_name):
            self.model.last_name = last_name
        case .mailChanging(mail: let mail):
            self.model.mail = mail
        case .phoneChanging(phone: let phone):
            self.model.phone = phone
        case .isAdminChanging(isAdmin: let isAdmin):
            self.model.isAdmin = isAdmin
        case .birthdateChanging(birthdate: let birthdate):
            self.model.birthdate = birthdate
        case .validateChange:
            break
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
}
