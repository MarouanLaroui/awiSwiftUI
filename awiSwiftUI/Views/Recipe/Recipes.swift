//
//  Recipes.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import SwiftUI

struct Recipes: View {
    
    @State var isFormDisplayed = false
    @State var selectedCategory : RecipeCategory? = nil
    @State var searchedRecipeName = ""
    var searchResult : [Recipe]{
        if(searchedRecipeName.isEmpty){
            return Recipe.recipes
        }
        return Recipe.recipes.filter({ $0.title.contains(searchedRecipeName)})
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Catégorie : ")
                Picker("Catégorie : ", selection: $selectedCategory) {
                    Text("Toutes")
                        .tag(nil as RecipeCategory?)
                    ForEach(RecipeCategory.categories) { category in
                        Text(category.name)
                    }
                }
            }
            
            RecipeGrid(recipes: searchResult)
                .overlay(
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button("+"){isFormDisplayed.toggle()}
                            .frame(width: 25, height: 25)
                            .font(.title)
                            .padding()
                            .background(Color.salmon)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            
                        
                        }
                    }
                    .padding()
                )
                .searchable(text: $searchedRecipeName,placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        Recipes()
    }
}
