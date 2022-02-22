//
//  AllergenCategoryListViewModel.swift
//  awiSwiftUI
//
//  Created by m1 on 21/02/2022.
//

import Foundation
import Combine

class AllergenCategoryListViewModel: ObservableObject, Subscriber {
        
    @Published var allergens : [AllergenCategory]
    
    init(allergens : [AllergenCategory]){
        self.allergens = allergens
    }
    
    typealias Input = AllergenCategoryIntentListState
    
    typealias Failure = Never
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: AllergenCategoryIntentListState) -> Subscribers.Demand {
        switch(input){
            
        case .upToDate:
            break
            
        case .listUpdated:
            print("Liste allergènes mise à jour")
            self.objectWillChange.send()
        }
        return .none
        
    }
}
