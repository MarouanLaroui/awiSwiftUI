//
//  TrackViewModel.swift
//  ListAndNavigation
//
//  Created by Marouan Laroui  on 16/02/2022.
//


import Foundation
import SwiftUI
import Combine

class RecipeListVM :  ObservableObject, Subscriber {
    
    @Published var recipes : [Recipe];
    
    init(recipes : [Recipe]){
        self.recipes = recipes
    }
    
    
    typealias Input = IntentListState
    
    typealias Failure = Never
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentListState) -> Subscribers.Demand {
        switch(input){
            
        case .upToDate:
            break
            
        case .listUpdated:
            print("Listeupdated")
            self.objectWillChange.send()
        case .appendList(ingredient: let ingredient):
            print(ingredient.unitaryPrice)
            break
        case .deleteElement(ingredientId: let ingredientId):
            print(ingredientId)
            break
        }
        return .none
        
    }
}
