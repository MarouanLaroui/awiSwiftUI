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
            self.steps.append(step)
            
        case .deleteElement(stepIndex: let stepIndex):
            self.steps.remove(at: stepIndex)
        }
        return .none
        
    }
    
}
