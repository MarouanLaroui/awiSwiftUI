//
//  TrackViewModel.swift
//  ListAndNavigation
//
//  Created by Marouan Laroui  on 16/02/2022.
//


import Foundation
import SwiftUI
import Combine

class UserListVM :  ObservableObject, Subscriber {
    
    @Published var users : [User];
    
    init(users : [User]){
        self.users = users
    }
    
    
    typealias Input = IntentUserListState
    
    typealias Failure = Never
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentUserListState) -> Subscribers.Demand {
        switch(input){
            
        case .upToDate:
            break
            
        case .listUpdated:
            print("----- user list object will change -----")
            self.objectWillChange.send()
            
        case .appendList(user: let user):
            self.users.append(user)
            
        case .deleteElement(userId: let userId):

            if let indexToDelete = self.users.firstIndex(where: {$0.id == userId}){
                self.users.remove(at: indexToDelete)
            }
        }
        return .none
        
    }
    
}
