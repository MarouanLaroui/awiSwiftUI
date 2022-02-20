//
//  IngredientFormViewModel.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 19/02/2022.
//

import Foundation
import SwiftUI
import Combine

class IngredientFormVM : IngredientDelegate, ObservableObject, Subscriber {
    
    
    
    

    
    private var model : Ingredient;
    
    @Published var id : Int?
    @Published var name : String
    @Published var unitaryPrice : Double
    @Published var nbInStock : Double
    @Published var allergen : AllergenCategory?
    @Published var category : IngredientCategory
    @Published var unity : Unity
    
    init(model : Ingredient){
        
        self.id = model.id
        self.name = model.name
        self.unitaryPrice = model.unitaryPrice
        self.nbInStock = model.nbInStock
        self.allergen = model.allergen
        self.category = model.category
        self.unity = model.unity
        
        self.model = model
        self.model.delegate = self
        
        print("in IngredientFORMVM model :" + model.name)
    }
    
    func ingredientChange(name: String) {
        self.name = name
    }
    
    func ingredientChange(unitaryPrice: Double) {
        self.unitaryPrice = unitaryPrice
    }
    
    func ingredientChange(nbInStock: Double) {
        self.nbInStock = nbInStock
    }
    
    func ingredientChange(allergenCategory: AllergenCategory?) {
        self.allergen = allergenCategory
    }
    
    func ingredientChange(ingredientCategory: IngredientCategory) {
        self.category = ingredientCategory
    }
    
    func ingredientChange(unity: Unity) {
        self.unity = unity
    }
    
    func ingredientChange(id: Int) {
        self.id = id
    }
    
    typealias Input = IntentState
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: IntentState) -> Subscribers.Demand {
        print("receive Intent IngredientFormVM : ")
        switch(input){
            
        case .ready:
            break
            
        case .ingredientNameChanging(let name):
            self.model.name = name
            
        case .unitaryPriceChanging(let unitaryPrice):
            self.model.unitaryPrice = unitaryPrice
            
        case .nbInStockChanging(let nbInStock):
            self.model.nbInStock = nbInStock
            
       
        case .allergenCategoryChanging(let allergenCategory):
            self.model.allergen = allergenCategory
            
        case .ingredientCategoryChanging(let ingredientCategory):
            self.model.category = ingredientCategory
            
        case .unityChanging(let unity):
            self.model.unity = unity
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
}

