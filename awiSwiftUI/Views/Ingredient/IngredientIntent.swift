//
//  Ingredient.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import Foundation
import Combine
import SwiftUI

enum IntentListState{
    case upToDate
    case listUpdated
    case appendList(ingredient : Ingredient)
}

enum IntentState{
    case ready
    case ingredientNameChanging(name : String)
    case unitaryPriceChanging(unitaryPrice : Double)
    case nbInStockChanging(nbInStock :  Double)
    case ingredientCategoryChanging(ingredientCategory : IngredientCategory)
    case allergenCategoryChanging(allergenCategory : AllergenCategory?)
    case unityChanging(unity : Unity)
    case validateChange
}


struct Intent{
    
    @State private var state = PassthroughSubject<IntentState,Never>()
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
    }
    
    func intentToChange(unitaryPrice : Double){
        self.state.send(.unitaryPriceChanging(unitaryPrice: unitaryPrice))
        
    }
    
    func intentToChange(nbInStock : Double){
        self.state.send(.nbInStockChanging(nbInStock: nbInStock))
    }
    
    func intentToChange(ingredientCategory : IngredientCategory){
        self.state.send(.ingredientCategoryChanging(ingredientCategory: ingredientCategory))
    }
    
    func intentToChange(allergenCategory : AllergenCategory?){
        self.state.send(.allergenCategoryChanging(allergenCategory: allergenCategory))
    }
    
    func intentToChange(unity : Unity){
        self.state.send(.unityChanging(unity: unity))
    }
    func intentToCreateIngredient(ingredient : Ingredient, isUpdate : Bool) async {
//
//        Task{
//            await
//            Dispatch main async, permet d'executer une action a la fin d'une tache
//
//        }
        let response = await IngredientDAO.postIngredient(ingredient: ingredient)
        
        switch(response){
            
        case .success(let postedIngredient):
            
            self.state.send(.validateChange)
            if(!isUpdate){
                self.listState.send(.appendList(ingredient: postedIngredient))
            }
            else{
                self.listState.send(.listUpdated)
            }
            
        case .failure(let error):
            print("ERROR : " + error.localizedDescription)
            return
        }
        
        
    }

}

