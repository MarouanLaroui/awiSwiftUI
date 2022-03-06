//
//  SelectIngredientForStep.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 01/03/2022.
//

import SwiftUI

struct SelectIngredientForStep: View {
    
    var intent : StepIntent
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var ingredients : [Ingredient] = []
    @State var searchedIngredientName : String = ""
    
    var searchedIngredient : [Ingredient]{
        if(searchedIngredientName.isEmpty){
            return self.ingredients
        }
        else{
            return ingredients.filter({$0.name.contains(searchedIngredientName)})
        }
    }
    
    var body: some View {
        VStack{
            List(searchedIngredient){
                ingredient in
                Text(ingredient.name)
                    .onTapGesture {
                        self.intent.intentToChange(ingredientToAdd: ingredient)
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .searchable(text: $searchedIngredientName,placement: .navigationBarDrawer(displayMode: .always))
        .task{
            let reqIngredients = await IngredientDAO.getIngredients()
            
            switch(reqIngredients){
                
            case .success(let resIngredients):
                self.ingredients = resIngredients
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
