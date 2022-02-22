//
//  AllergenRow.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct AllergenRow: View{
    @State var allergen: AllergenCategory
    @State var ingredients: [Ingredient] = []
    @State var showingList = false
    
    var body: some View{
        
        HStack{
            
            
            if ingredients.count == 0{
                //Allergen name
                Text(allergen.name)
                    .font(.title3)
                    .bold()
                    .italic()
                    .opacity(0.6)
            }
            else {
                //Il y a des ingrédients à afficher
                
                //Allergen name
                Text(allergen.name)
                    .font(.title3)
                    .bold()
                    .onTapGesture {
                        showingList = !showingList
                    }
                Image("warning")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        showingList = !showingList
                    }
                Text(String(ingredients.count))
                    .foregroundColor(.salmon)
                    .font(.caption)
                
            }
        }
        
        HStack{
        
            //Il y a des ingrédients à afficher
            HStack{
                if showingList {
                    VStack(alignment: .leading){
                        ForEach(ingredients){ ingredient in
                            Text(ingredient.name)
                        }
                    }
                }
            }
        }
        .task{
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
