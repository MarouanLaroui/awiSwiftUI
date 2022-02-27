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

struct StepIntent{
    
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
        

}


