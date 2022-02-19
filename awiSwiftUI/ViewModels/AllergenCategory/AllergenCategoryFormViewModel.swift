//
//  AllergenCategoryFormViewModel.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import Foundation

class AllergenCategoryFormViewModel : AllergenCategoryDelegate , ObservableObject{
    
    private var model : AllergenCategory
    
    @Published var name : String{
        didSet{
            if(self.model.name != self.name){
                self.model.name = self.name
                if(self.model.name != self.name){
                    self.name = self.model.name
                }
            }
        }
    }
    
    init(model : AllergenCategory){
        self.name = model.name
        self.model = model
        self.model.delegate = self
    }
    
    func allergenCategoryChange(name: String) {
        self.name = name
    }
    
    func allergenCategoryChange(id: Int) {
    }
}
