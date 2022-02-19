//
//  IngredientCategoryFormViewModel.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import Foundation

class IngredientCategoryFormViewModel : IngredientCategoryDelegate, ObservableObject{
    
    private var model = IngredientCategory(category_name:"")
    
    @Published var category_name : String{
        didSet{
            if(self.model.category_name != self.category_name){
                self.model.category_name = self.category_name
                if(self.model.category_name != self.category_name){
                    self.category_name = self.model.category_name
                }
            }
        }
    }
    
    init(model : IngredientCategory){
        self.category_name = model.category_name
        self.model = model
        self.model.delegate = self
    }
    
    func ingredientCategoryChange(category_name: String) {
        self.category_name = category_name
    }
    
    func ingredientCategoryChange(id: Int) {
    }
    
}
