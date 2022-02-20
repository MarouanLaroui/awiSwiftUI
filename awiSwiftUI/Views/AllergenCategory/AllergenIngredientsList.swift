//
//  AllergenIngredientsList.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI


/*Button(String(ingredients.count)){
    showingList.toggle()
}
.foregroundColor(.salmon)
.sheet(isPresented: $showingList){
    Spacer()
    Text(allergen.name)
        .font(.title)
        .padding()
    
    ForEach(ingredients){ ingredient in
        Text(ingredient.name)
            .font(.title2)
    }
}*/
struct AllergenIngredientsList: View{
    
    @State var allergen: AllergenCategory
    @State var ingredients: [Ingredient] = []
    @State var showingList = false
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View{
        HStack{
            VStack(alignment: .trailing){
                
                //Liste des ingrédients
                if ingredients.count == 0{
                    Text("Pas d'ingrédient")
                        .font(.caption)
                        .italic()
                        .opacity(0.6)
                }
                else {
                    //Il y a des ingrédients à afficher
                    HStack{
                        Image("warning")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        VStack(alignment: .leading){
                            ForEach(ingredients){ ingredient in
                                Text(ingredient.name)
                                    
                            }
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
