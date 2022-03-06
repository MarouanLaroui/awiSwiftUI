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
    
    @Published var category : IngredientCategory?{
        didSet{
            self.isDefaultCategory = false
            
        }
    }
    @Published var unity : Unity?{
        didSet{
            self.isDefaultUnity = false
        }
    }
    
    var isDefaultName = true
    var isDefaultCategory = true
    var isDefaultUnity = true
    
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
        
        self.copy.delegate = self
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
        if(self.allergen != allergenCategory){
            self.allergen = allergenCategory
        }
        
    }
    
    func ingredientChange(ingredientCategory: IngredientCategory) {
        if(self.category != ingredientCategory){
            self.category = ingredientCategory
            self.objectWillChange.send()
        }
    }
    
    func ingredientChange(unity: Unity) {
        if(self.unity != unity){
            self.unity = unity
        }
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
            print("isDefault name to false")
            self.isDefaultName = false
            self.copy.name = name
            
        case .unitaryPriceChanging(let unitaryPrice):
            self.copy.unitaryPrice = unitaryPrice
            
        case .nbInStockChanging(let nbInStock):
            self.copy.nbInStock = nbInStock
            
       
        case .allergenCategoryChanging(let allergenCategory):
            self.copy.allergen = allergenCategory
            
        case .ingredientCategoryChanging(let ingredientCategory):
            self.isDefaultCategory = false
            if let ingredientCategory = ingredientCategory {
                self.copy.category = ingredientCategory
            }
            
            
        case .unityChanging(let unity):
            self.isDefaultUnity = false
            if let unity = unity {
                self.copy.unity = unity
            }
            
            
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
        self.model.id = copy.id
        self.model.name = copy.name
        self.model.unitaryPrice = copy.unitaryPrice
        self.model.nbInStock = copy.nbInStock
        self.model.allergen = copy.allergen
        self.model.category = copy.category
        self.model.unity = copy.unity
    }
    var isValid : Bool {
        return self.copy.isValid && !isDefaultCategory && !isDefaultUnity && self.category != nil && self.unity != nil
    }
    
    var nameErrorMsg : String{
        if(!self.isDefaultName && self.copy.name.count == 0  ){
            return "Ce champ est obligatoire."
            
        }
        return ""
        
    }
    
    var unitaryPriceErrorMsg : String{
        if(self.copy.unitaryPrice < 0){
            return "Le prix unitaire doit être superieur à 0."
            
        }
        return ""
        
    }
    
    var nbInStockErrorMsg : String{
        if(self.nbInStock >= 0){
            return "Ce champ est obligatoirement positif."
        }
        return ""
        
    }
    
    var categoryErrorMsg : String{
        if(self.category == nil && !self.isDefaultCategory){
            return "Ce champ est obligatoire."
        }
        return ""
        
    }
    
    var unityErrorMsg : String{
        if(self.unity == nil && !self.isDefaultUnity){
            return "Ce champ est obligatoire."
            
        }
        return ""
        
    }
    
    func fieldAreNotDefault(){
        self.isDefaultUnity = false
        self.isDefaultCategory = false
        self.isDefaultName = false
        print("why")
    }
    
    
    
}

