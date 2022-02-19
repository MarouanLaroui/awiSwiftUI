//
//  AllergenIngredientsList.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct AllergenIngredientsList: View{
    
    @State var allergen: AllergenCategory
    @State var ingredients: [Ingredient] = []
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                List(ingredients){ ingredient in
                    Text(ingredient.name)
                    
                }
            }
            
        }
        .onAppear(){
            print("----- dans la liste des ingrédients")
        }
        .task {
            print("dans task de allergenIngredientsList -----------------------------------")

            async let requestIngredients : [Ingredient]? =  AllergenCategoryDAO.getIngredientByAllergen(id: self.allergen.id!)
            print("récupération des ingrédients pour " + allergen.name + "-------------------------------------")
            if let resAllergens = await requestIngredients{
                self.ingredients = resAllergens
            }
        }
    }
}
