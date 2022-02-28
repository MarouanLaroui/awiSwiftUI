//
//  RecipeIntent.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import Foundation
import Combine
import SwiftUI


enum RecipeIntentState{
    
    case ready
    case titleChanging(title : String)
    case servingChanging(nbOfServing : Int)
    case personInChargeChanging(personInCharge : String)
    case specEquipementChanging(specificEquipment : String)
    case dressEquipmentChanging(dressingEquipment : String)
    case recipeCatChanging(recipeCategory : RecipeCategory)
    case authorChanging(author : User)
    case createRecipe(recipe : Recipe)
    
}


struct RecipeIntent{
    
    @State private var state = PassthroughSubject<RecipeIntentState,Never>()
    
    
    func addObserver(viewModel : RecipeVM){
        self.state.subscribe(viewModel)
    }
    
    func intentToChange(title : String){
        self.state.send(.titleChanging(title: title))
    }
    
    func intentToChange(nbOfServing : Int){
        self.state.send(.servingChanging(nbOfServing: nbOfServing))
        
    }
    
    func intentToChange(personInCharge : String){
        self.state.send(.personInChargeChanging(personInCharge: personInCharge))
    }
    
    func intentToChange(specificEquipment : String){
        self.state.send(.specEquipementChanging(specificEquipment: specificEquipment))
    }
    
    func intentToChange(dressingEquipment : String){
        self.state.send(.dressEquipmentChanging(dressingEquipment: dressingEquipment))
    }
    
    func intentToChange(recipeCategory : RecipeCategory){
        self.state.send(.recipeCatChanging(recipeCategory: recipeCategory))
    }
    
    func intentToChange(author : User){
        self.state.send(.authorChanging(author: author))
    }
    
    
    func intentToCreateRecipe(recipe : Recipe, isUpdate : Bool) async {
        /*
        let response = await RecipeDAO.
        
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
         */

    }

}

