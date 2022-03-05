//
//  TrackViewModel.swift
//  ListAndNavigation
//
//  Created by Marouan Laroui  on 16/02/2022.
//


import Foundation
import SwiftUI
import Combine

class StepListVM :  ObservableObject, Subscriber {
    
    @Published var steps : [Step];
    
    init(steps : [Step]){
        self.steps = steps
    }
    
    
    typealias Input = IntentStepListState
    
    typealias Failure = Never
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentStepListState) -> Subscribers.Demand {
        switch(input){
            
        case .upToDate:
            break
            
        case .listUpdated:
            self.objectWillChange.send()
            
        case .appendList(step: let step):
            print("In StepListVM before")
            self.steps.forEach({
                print($0.title)
            })
            self.steps.append(step)
            print("after insertion")
            self.steps.forEach({
                print($0.title)
            })
            
        case .deleteElement(step: let step):
            if let indexToDelete = self.steps.firstIndex(where: {$0 == step}){
                self.steps.remove(at: indexToDelete)
            }
        }
        return .none
        
    }
    
}
