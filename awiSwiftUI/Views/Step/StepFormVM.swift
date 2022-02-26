//
//  RecipeVM.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import Foundation
import SwiftUI
import Combine

class StepFormVM : ObservableObject, StepDelegate, Subscriber{

    
    typealias Input = StepIntentState
    
    typealias Failure = Never
    
    
    private var model : Step;
    
    @Published var id : Int?
    @Published var title : String
    @Published var description : String
    @Published var time : Int
    
    init(model : Step){
        
        self.id = model.id
        self.title = model.title
        self.description = model.description
        self.time = model.time
        
        self.model = model
        self.model.delegate = self
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: StepIntentState) -> Subscribers.Demand {
        switch(input){
            
        case .ready:
            //todo
            break
        case .titleChanging(title: let title):
            self.model.title = title
        case .descriptionChanging(description: let description):
            self.model.description = description
        case .timeChanging(time: let time):
            self.model.time = time
        case .createStep(recipeId: let recipeId):
            //todo
            break
        case .createStepToRecipe(recipeId: let recipeId):
            //todo
            break
        case .createStepToIngredient:
            //todo
            break
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func stepChange(id: Int?) {
        self.id = id
    }
    
    func stepChange(title: String) {
        self.title = title
    }
    
    func stepChange(description: String) {
        self.description = description
    }
    
    func stepChange(time: Int) {
        self.time = time
    }
    
    
    
    
}
