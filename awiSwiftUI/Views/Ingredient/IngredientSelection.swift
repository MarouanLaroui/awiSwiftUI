//
//  StepForm.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import SwiftUI

struct IngredientSelection: View {
    
    @State var ingredients : [Ingredient] = []
    @State var searchedIngredientName = ""
    var searchResult : [Ingredient]{
        if(searchedIngredientName.isEmpty){
            return self.ingredients;
        }
        return self.ingredients.filter({$0.name.contains(searchedIngredientName)})
    }
    
    var body: some View {
        VStack{
            List(searchResult){
                ingredient in
                Text(ingredient.name)
            }
        }
        .task {
            let result = await IngredientDAO.getIngredients()
            
            switch(result){
                
            case .success(let resIngredients):
                self.ingredients = resIngredients
            case .failure(_):
                print("failure while retrieving ingredients")
            }
        }
        .navigationTitle("Ingredient Selection")
    }
}
/*
struct IngredientSelection_Previews: PreviewProvider {
    static var previews: some View {
        StepForm()
    }
}
*/
