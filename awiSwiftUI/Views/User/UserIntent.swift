//
//  Ingredient.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation
import Combine
import SwiftUI

enum IntentUserListState{
    case upToDate
    case listUpdated
    case appendList(user : User)
    case deleteElement(userId : Int)
}

enum IntentUserState{
    case ready
    case nameChanging(name : String)
    case lastNameChanging(last_name : String)
    case mailChanging(mail :  String)
    case phoneChanging(phone : String)
    case isAdminChanging(isAdmin : Bool)
    case birthdateChanging(birthdate : String)
    case userCreation(user : User)
    case validateChange
}


struct UserIntent{
    
    @State private var state = PassthroughSubject<IntentUserState,Never>()
    private var listState = PassthroughSubject<IntentUserListState,Never>()
    
    
    func addListObserver(viewModel : UserListVM){
        self.listState.subscribe(viewModel)
    }
    
    func addObserver(viewModel : UserVM){
        self.state.subscribe(viewModel)
    }
    
    func intentToChangeList(){
        self.listState.send(.listUpdated)
    }
    
    // 2) avertit les subsscriber que l'état a changé
    
    func intentToChange(name : String){
        self.state.send(.nameChanging(name: name))
    }
    
    func intentToChange(last_name : String){
        self.state.send(.lastNameChanging(last_name: last_name))
    }
    
    func intentToChange(mail : String){
        self.state.send(.mailChanging(mail: mail))
    }
    
    func intentToChange(phone : String){
        self.state.send(.phoneChanging(phone: phone))
    }
    
    func intentToChange(birthdate : String){
        self.state.send(.birthdateChanging(birthdate: birthdate))
    }
    func intentToChange(isAdmin : Bool){
        self.state.send(.isAdminChanging(isAdmin: isAdmin))
    }
    
    func intentToPostUser(user : User) async{

        let postUserResult = await UserDAO.postUser(user: user)
    
        switch(postUserResult){
            
        case .success(let resUser):
            /*If update*/
            if let userId = user.id{
                self.state.send(.validateChange)
                self.listState.send(.listUpdated)
            }
            /*If creation*/
            else{
                self.listState.send(.appendList(user: resUser))
            }
            
            break
        case .failure(_):
            break
        }
        
    }
    
    func intentToDeleteUser(user : User) async {
        
        let response = await JSONHelper.httpDelete(url: Utils.apiURL + "user/" +  String(user.id!))
        
        switch(response){
            
        case .success(let nbAffectedRows):
            
            if(nbAffectedRows>0){
                self.listState.send(.deleteElement(userId : user.id!))
            }
            //Gérer cas fail ?
            else{
                self.listState.send(.listUpdated)
            }
            
        case .failure(let error):
            print("ERROR : " + error.localizedDescription)
            return
        }
    }

}

