//
//  TrackViewModel.swift
//  ListAndNavigation
//
//  Created by Marouan Laroui  on 16/02/2022.
//


import Foundation
import SwiftUI
import Combine

class IngredientListVM :  ObservableObject, Subscriber {
    
    @Published var ingredients : [Ingredient];
    
    init(ingredients : [Ingredient]){
        self.ingredients = ingredients
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
            self.objectWillChange.send()
            
        case .appendList(ingredient: let ingredient):
            self.ingredients.append(ingredient)
            
        case .deleteElement(ingredientId: let ingredientId):
            print("DeleteElement state detected in IngredientListVM")
            if let indexToDelete = self.ingredients.firstIndex(where: {$0.id == ingredientId}){
                self.ingredients.remove(at: indexToDelete)
            }
        }
        return .none
        
    }
    
}
