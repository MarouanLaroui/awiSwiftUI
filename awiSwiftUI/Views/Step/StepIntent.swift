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
    case quantityOfIngredientChanging(ingredient : Ingredient, quantity : Int)
    case createStep(recipeId : Int)
    case createStepToRecipe(recipeId : Int)
    case createStepToIngredient
    
}

enum IntentStepListState{
    case upToDate
    case listUpdated
    case appendList(step: Step)
    case deleteElement(step: Step)
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
    
    func intentToChange(ingredient : Ingredient, quantity : Int){
        self.state.send(.quantityOfIngredientChanging(ingredient: ingredient, quantity: quantity))
    }
    
    func intentToChange(stepToAdd : Step, recipeId : Int) async{
        
        
        let res : Result<Step,Error>
        if let stepId = stepToAdd.id {
            print("deletion of stepToingredient")
            let deletionResult = await StepToIngredientDAO.deleteStepToIngredientOfStep(stepId: stepId)
            switch(deletionResult){
                
            case .success(let nbOfRows):
                print(nbOfRows)
            case .failure(_):
                print("deletion error in stepintent")
            }

            res = await StepDAO.updateStepOfRecipe(recipeId: recipeId, step: stepToAdd, stepNbOfOrder: 2)
        }
        else{
            res = await StepDAO.createStepOfRecipe(recipeId: recipeId, step: stepToAdd, stepNbOfOrder: 2)
        }
        
        
        
        switch(res){
        case .success(let step):
            //if(stepToAdd.id == nil)self.listState.send(.appendList(step: stepToAdd))
            print("success")
        case .failure(let error):
            print("error")
            print(error.localizedDescription)
        }
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
    
    func intentToDeleteStep(step : Step) async -> Result<Int,Error>{
        if let stepId = step.id{
            let deletionRes = await StepDAO.deleteStep(stepId: stepId)
            
            switch(deletionRes){
                
            case .success(let nbRows):
                self.listState.send(.deleteElement(step: step))
                return .success(nbRows)
            case .failure(let error):
                return .failure(error)
            }
        }
        else{
            self.listState.send(.deleteElement(step: step))
            return .success(1)
        }
        
    }
    /*
    func intentToDeleteIngredientFromStep(stepId : Int, ingredientId : Int) async -> Result<Int,Error>{
        //Je suis en train de faire ça supprime pas
        
        if let stepId = step.id{
            let deletionRes = await StepDAO.deleteIngredientFromStep(stepId: stepId, ingredientId: ingredientId)
            
            switch(deletionRes){
                
            case .success(let nbRows):
                self.listState.send(.deleteElement(step: step))
                return .success(nbRows)
            case .failure(let error):
                return .failure(error)
            }
        }
        else{
            self.listState.send(.deleteElement(step: step))
            return .success(1)
        }
         
        
    }
     */


}


