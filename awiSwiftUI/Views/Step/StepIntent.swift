//
//  StepIntent.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import Foundation
import Combine
import SwiftUI

enum StepIntentState{
    
    case ready
    case titleChanging(title : String)
    case descriptionChanging(description : String)
    case timeChanging(time : Int)
    case addIngredient(ingredient : Ingredient)
    case deleteIngredient(ingredient : Ingredient)
    
    case createStep(recipeId : Int)
    case createStepToRecipe(recipeId : Int)
    case createStepToIngredient
    
}

enum IntentStepListState{
    case upToDate
    case listUpdated
    case appendList(step: Step)
    case deleteElement(stepIndex: Int)
}

class StepIntent{
    
    @State private var state = PassthroughSubject<StepIntentState,Never>()
    @State private var listState = PassthroughSubject<IntentStepListState,Never>()
    
    func addObserver(viewModel : StepFormVM){
        self.state.subscribe(viewModel)
    }
    
    func addObserverList(viewModel : StepListVM){
        self.listState.subscribe(viewModel)
    }

    func intentToChange(title : String){
        self.state.send(.titleChanging(title: title))
    }
    
    func intentToChange(description : String){
        self.state.send(.descriptionChanging(description: description))
        
    }
    
    func intentToChange(time : Int){
        self.state.send(.timeChanging(time: time))
    }
    
    func intentToChange(ingredientToAdd : Ingredient){
        self.state.send(.addIngredient(ingredient: ingredientToAdd))
    }
    
    func intentToChange(ingredientToDelete : Ingredient){
        self.state.send(.deleteIngredient(ingredient: ingredientToDelete))
    }
    
    func intentToChange(stepToAdd : Step){
        self.listState.send(.appendList(step: stepToAdd))
    }
    
    func intentToCreateSteps(recipeId : Int, steps : [Step]) async -> Result<[Step],Error>{
        print("intent to create steps in stepIntent")
        var nbOfOrder = 1
        
        for step in steps {
            let res = await StepDAO.createStepOfRecipe(recipeId: recipeId, step: step, stepNbOfOrder: nbOfOrder)
            nbOfOrder = nbOfOrder + 1
        }
        
        return .success([])

    }


}


