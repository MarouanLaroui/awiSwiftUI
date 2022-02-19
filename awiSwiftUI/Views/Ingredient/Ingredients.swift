//
//  Ingredients.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct Ingredients: View {
    
    @State var ingredients : [Ingredient] = []
    @State var ingredientCategories : [IngredientCategory] = []
    @State var searchedIngredientName = ""
    @State var isFormDisplayed = false
    @State var selectedCategory : IngredientCategory?
    
    
    var searchResult : [Ingredient]{
        if(searchedIngredientName.isEmpty){
            return ingredients;
        }
        return ingredients.filter({$0.name.contains(searchedIngredientName)})
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Catégorie :")
                
                Picker("Catégorie : ", selection: $selectedCategory) {
                    Text("Toutes")
                        .tag(nil as IngredientCategory?)
                    ForEach(ingredientCategories) { category in
                        Text(category.category_name)
                    }
                }
                
            }
            
            //Button(action: {isFormDisplayed.toggle()}) {Text("+")}
            
            List(searchResult){
                ingredient in
                IngredientRow(ingredient: ingredient)
                /*
                 NavigationLink(destination: Text(ingredient.name)) {
                 Text(ingredient.name)
                 }
                 */
                
            }
            .searchable(text: $searchedIngredientName,placement: .navigationBarDrawer(displayMode: .always))
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
        }
        .task{
            
            async let reqIngredients =  IngredientDAO.getIngredients()
            
            async let reqCategories = IngredientCategoryDAO.getIngredientCategories()
            
            
            switch(await reqIngredients){
                
            case .success(let resIngredients):
                ingredients = resIngredients
            case .failure(let error):
                print(error)
            }
            
            switch(await reqCategories){
                
            case .success(let resIngredientCategories):
                ingredientCategories = resIngredientCategories
            case .failure(let error):
                print(error)
            }
            
        }
        .sheet(isPresented: $isFormDisplayed, onDismiss: didDismiss){
            IngredientForm()
            
        }
        .toolbar {
            HStack{
                Image(systemName: "person")
            }
            
        }
    }
    
    
    func didDismiss(){
        
    }
    
    
}

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            Ingredients(ingredients: Ingredient.ingredients)
        }
        
    }
}
