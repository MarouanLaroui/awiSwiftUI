//
//  Ingredient.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation
import Combine


enum IntentListState{
    case upToDate
    case listUpdated
}

enum IntentState{
    case ready
    case ingredientNameChanging(name : String)
    case unitaryPriceChanging(unitaryPrice : Double)
    case nbInStockChanging(nbInStock :  Double)
    case ingredientCategoryChanging(ingredientCategory : IngredientCategory)
    case allergenCategoryChanging(allergenCategory : AllergenCategory?)
    case unityChanging(unity : Unity)
}


struct Intent{
    
    private var state = PassthroughSubject<IntentState,Never>()
    private var listState = PassthroughSubject<IntentListState,Never>()
    
    
    
    func addListObserver(viewModel : IngredientListVM){
        print("------ addListObserver IngredientIntent-------")
        self.listState.subscribe(viewModel)
    }
    
    func addObserver(viewModel : IngredientFormVM){
        print("------ Observer IngredientIntent-------")
        self.state.subscribe(viewModel)
    }
    
    func intentToChangeList(){
        self.listState.send(.listUpdated)
    }
    
    // 2) avertit les subsscriber que l'état a changé
    func intentToChange(name : String){
        self.state.send(.ingredientNameChanging(name : name))
        self.listState.send(.listUpdated)
    }
    
    func intentToChange(unitaryPrice : Double){
        self.state.send(.unitaryPriceChanging(unitaryPrice: unitaryPrice))
        self.listState.send(.listUpdated)
    }
    
    func intentToChange(nbInStock : Double){
        self.state.send(.nbInStockChanging(nbInStock: nbInStock))
        self.listState.send(.listUpdated)
    }
    
    func intentToChange(ingredientCategory : IngredientCategory){
        self.state.send(.ingredientCategoryChanging(ingredientCategory: ingredientCategory))
        self.listState.send(.listUpdated)
    }
    
    func intentToChange(allergenCategory : AllergenCategory?){
        self.state.send(.allergenCategoryChanging(allergenCategory: allergenCategory))
        self.listState.send(.listUpdated)
    }
    
    func intentToChange(unity : Unity){
        self.state.send(.unityChanging(unity: unity))
        self.listState.send(.listUpdated)
    }

}

