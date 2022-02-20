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
        .task{
            print("id de l'allergène"+String(allergen.id!))
            async let requestIngredients = AllergenCategoryDAO.getIngredientByAllergen(id: self.allergen.id!)
            
            switch(await requestIngredients){
                
            case .success(let resIngredients):
                ingredients = resIngredients
            case .failure(let error):
                print(error)
            }
        }
    }
}
