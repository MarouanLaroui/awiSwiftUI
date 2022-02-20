//
//  IngredientFormViewModel.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import Foundation

class IngredientFormViewModel : IngredientDelegate, ObservableObject{
    
    private var model : Ingredient
    
    @Published var id : Int?{
        didSet{
            if(self.id != self.model.id){
                self.model.id = self.id
                if(self.id != self.model.id){
                    self.id = self.model.id
                }
            }
        }
    }
    
    @Published var name : String{
        didSet{
            if(self.name != self.model.name){
                self.model.name = self.name
                if(self.name != self.model.name){
                    self.name = self.model.name
                }
            }
        }
    }
    
    @Published var unitaryPrice : Double{
        didSet{
            if(self.unitaryPrice != self.model.unitaryPrice){
                self.model.unitaryPrice = self.unitaryPrice
                if(self.unitaryPrice != self.model.unitaryPrice){
                    self.unitaryPrice = self.model.unitaryPrice
                }
                
            }
        }
    }
    
    @Published var nbInStock : Double{
        didSet{
            if(self.nbInStock != self.model.nbInStock){
                self.model.nbInStock = self.nbInStock
                if(self.nbInStock != self.model.nbInStock){
                    self.nbInStock = self.model.nbInStock
                }
                
            }
        }
    }
    
    
    @Published var allergenCategory : AllergenCategory?
    /*{
        /
        didSet{
            if(self.allergenCategory?.id != self.model.allergenCategory.id){
                self.model.allergenCategory = self.allergenCategory
                if(self.model.allergenCategory.id != self.allergenCategory){
                    self.allergenCategory = self.model.allergenCategory
                }
            }
        }
         
    }*/
    @Published var ingredientCategory : IngredientCategory{
        
        didSet{
            if(self.ingredientCategory.id != self.model.category.id){
                self.model.category = self.ingredientCategory
                if(self.model.category.id != self.ingredientCategory.id){
                    self.ingredientCategory = self.model.category
                }
            }
        }
         
    }
    @Published var unity : Unity{
        didSet{
            if(self.unity.id != self.model.unity.id){
                self.model.unity = unity
                if(self.unity.id != self.model.unity.id){
                    self.unity = self.model.unity
                }
            }
        }
    }
    
    init(model : Ingredient){
        
        self.id = model.id
        self.name = model.name
        self.unitaryPrice = model.unitaryPrice
        self.nbInStock = model.nbInStock
        self.allergenCategory = model.allergen
        self.ingredientCategory = model.category
        self.unity = model.unity
        
        self.model = model
        self.model.delegate = self
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
        self.allergenCategory = allergenCategory
    }
    
    func ingredientChange(ingredientCategory: IngredientCategory) {
        self.ingredientCategory = ingredientCategory
    }
    
    func ingredientChange(unity: Unity) {
        self.unity = unity
    }
    
    func ingredientChange(id: Int) {
        self.id = id
    }
}
