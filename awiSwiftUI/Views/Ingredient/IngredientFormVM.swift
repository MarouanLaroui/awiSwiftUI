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
    private (set) var copy : Ingredient;
    
    @Published var id : Int?
    @Published var name : String
    @Published var unitaryPrice : Double
    @Published var nbInStock : Double
    @Published var allergen : AllergenCategory?
    @Published var category : IngredientCategory
    @Published var unity : Unity
    
    var isDefaultName = true
    
    init(model : Ingredient){
        
        self.id = model.id
        self.name = model.name
        self.unitaryPrice = model.unitaryPrice
        self.nbInStock = model.nbInStock
        self.allergen = model.allergen
        self.category = model.category
        self.unity = model.unity
        
        self.model = model
        self.copy = Ingredient(
            id: model.id,
            name: model.name,
            unitaryPrice: model.unitaryPrice,
            nbInStock: model.nbInStock,
            allergen: model.allergen,
            ingredientCategory: model.category,
            unity: model.unity)
        self.model.delegate = self
    }
    
    // MARK: -
    // MARK: Ingredient delegate
    
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
    // MARK: -
    // MARK: State observer
    
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
            self.isDefaultName = false
            self.copy.name = name
            
        case .unitaryPriceChanging(let unitaryPrice):
            self.copy.unitaryPrice = unitaryPrice
            
        case .nbInStockChanging(let nbInStock):
            self.copy.nbInStock = nbInStock
            
       
        case .allergenCategoryChanging(let allergenCategory):
            self.copy.allergen = allergenCategory
            
        case .ingredientCategoryChanging(let ingredientCategory):
            self.copy.category = ingredientCategory
            
        case .unityChanging(let unity):
            self.copy.unity = unity
            
        case .validateChange:
            self.model.name = copy.name
            self.model.unitaryPrice = copy.unitaryPrice
            self.model.nbInStock = copy.nbInStock
            self.model.allergen = copy.allergen
            self.model.category = copy.category
            self.model.unity = copy.unity
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func rollback(){
        print("--------rollback-----")
        print(copy.name)
        self.model.id = copy.id
        self.model.name = copy.name
        self.model.unitaryPrice = copy.unitaryPrice
        self.model.nbInStock = copy.nbInStock
        self.model.allergen = copy.allergen
        self.model.category = copy.category
        self.model.unity = copy.unity
    }
    var isValid : Bool {
        self.copy.isValid
    }
    var nameErrorMsg : String{
        if(self.isDefaultName || self.copy.name.count > 0  ){
            return ""
        }
        return "Ce champs est obligatoire"
    }
    
    var unitaryPriceErrorMsg : String{
        if(self.copy.unitaryPrice > 0){
            return ""
        }
        return "Le prix unitaire doit être superieur à 0"
    }
    
    var nbInStockErrorMsg : String{
        if(self.nbInStock >= 0){
            return ""
        }
        return "Ce champs est obligatoire"
    }
    
    
    
    
}

