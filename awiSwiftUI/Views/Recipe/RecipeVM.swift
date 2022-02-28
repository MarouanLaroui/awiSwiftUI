//
//  RecipeVM.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import Foundation
import SwiftUI
import Combine

class RecipeVM : ObservableObject, RecipeDelegate, Subscriber{
    
    typealias Input = RecipeIntentState
    
    typealias Failure = Never
    
    
    private var model : Recipe;
    
    @Published var id : Int?
    @Published var title : String
    @Published var nbOfServing : Int
    @Published var personInCharge : String
    @Published var specificEquipment : String
    @Published var dressingEquipment : String
    @Published var recipeCategory : RecipeCategory
    @Published var author : User
    
    
    init(model : Recipe){
        
        self.id = model.id
        self.title = model.title
        self.personInCharge = model.personInCharge
        self.nbOfServing = model.nbOfServing
        self.specificEquipment = model.specificEquipment
        self.dressingEquipment = model.dressingEquipment
        self.recipeCategory = model.recipeCategory
        self.author = model.author
        
        self.model = model
        self.model.delegate = self
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: RecipeIntentState) -> Subscribers.Demand {
        switch(input){
            
        case .ready:
            //todo ?
            break
        case .titleChanging(title: let title):
            self.model.title = title
            
        case .servingChanging(nbOfServing: let nbOfServing):
            self.model.nbOfServing = nbOfServing
            
        case .personInChargeChanging(personInCharge: let personInCharge):
            self.model.personInCharge = personInCharge
            
        case .specEquipementChanging(specificEquipment: let specificEquipment):
            self.model.specificEquipment = specificEquipment
            
        case .dressEquipmentChanging(dressingEquipment: let dressingEquipment):
            self.model.dressingEquipment = dressingEquipment
            
        case .recipeCatChanging(recipeCategory: let recipeCategory):
            self.model.recipeCategory = recipeCategory
            
        case .authorChanging(author: let author):
            self.model.author = author
            
        case .createRecipe(recipe: let recipe):
            //TODO
            break
        }
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    
    func RecipeChange(id: Int) {
        self.id = id
    }
    
    func RecipeChange(title: String) {
        self.title = title
    }
    
    func RecipeChange(nbOfServing: Int) {
        self.nbOfServing = nbOfServing
    }
    
    func RecipeChange(personInCharge: String) {
        self.personInCharge = personInCharge
    }
    
    func RecipeChange(specificEquipment: String) {
        self.specificEquipment = specificEquipment
    }
    
    func RecipeChange(dressingEquipment: String) {
        self.dressingEquipment = dressingEquipment
    }
    
    func RecipeChange(recipeCategory: RecipeCategory) {
        self.recipeCategory = recipeCategory
    }
    
    
}
