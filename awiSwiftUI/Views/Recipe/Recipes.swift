//
//  Recipes.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import SwiftUI

struct Recipes: View {
    
    @ObservedObject var recipesVM : RecipeListVM = RecipeListVM(recipes: [])
    @State var recipeCategories : [RecipeCategory] = []
    @State var selectedCategory : RecipeCategory? = nil
    @State var searchedRecipeName = ""
    @State var isRecipeCreationShowed : Bool = false
    @State var selectedRecipe : Recipe?
    @State var showRecipeModificationSheet : Bool = false
    
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    
    var searchResult : [Recipe]{
        if(searchedRecipeName.isEmpty){
            if(self.selectedCategory != nil){
                return recipesVM.recipes.filter({ $0.recipeCategory.name == self.selectedCategory!.name})
            }
            return recipesVM.recipes
        }
        else{
            if let selectedCategory = self.selectedCategory {
                return recipesVM.recipes.filter({
                    return $0.title.contains(searchedRecipeName) && $0.recipeCategory.name == self.selectedCategory!.name
                    
                })
            }
            return recipesVM.recipes.filter({ $0.title.contains(searchedRecipeName)})
        }
        
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Catégorie : ")
                Picker("Catégorie : ", selection: $selectedCategory) {
                    Text("Toutes")
                        .tag(nil as RecipeCategory?)
                    ForEach(recipeCategories) { category in
                        Text(category.name).tag(category as RecipeCategory?)
                    }
                }

                
            }
            ScrollView {
                LazyVGrid(columns: gridItems,spacing: 0){
                    ForEach(self.searchResult){ recipe in
                        NavigationLink(destination: RecipeDetailledView(recipe : recipe)){
                            RecipeCard(recipe: recipe)
                                .frame(width: 170, height: 250)
                        }
                        .foregroundColor(.black)
                        
                    }
                }
            }
            .overlay(
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        NavigationLink(destination: RecipeForm(recipeVM: RecipeVM(model: Recipe(title: "", nbOfServing: 1, personInCharge: "", specificEquipment: "", dressingEquipment: "", recipeCategory: RecipeCategory.categories[0], author: User.users[0])))) {
                            Text("+")
                            .frame(width: 25, height: 25)
                            .font(.title)
                            .padding()
                            .background(Color.salmon)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                         
                        }
                    }
                }
                .padding()
            )
            .searchable(text: $searchedRecipeName,placement: .navigationBarDrawer(displayMode: .always))
        }
        .task{
                async let reqRecipes =  RecipeDAO.getRecipes()
                async let reqRecipeCategories =  RecipeCategoryDAO.getRecipeCategories()
                
                switch(await reqRecipes){
                    
                case .success(let resRecipes):
                    self.recipesVM.recipes = resRecipes
                case .failure(let error):
                    print(error)
    
                }
                
                switch(await reqRecipeCategories){
                    
                case .success(let resRecipeCategories):
                    self.recipeCategories = resRecipeCategories
                case .failure(let error):
                    print(error)
    
                }
        }

        .toolbar {
            HStack{
                NavigationLink(destination: UserAccountView()){
                    HStack {
                        Image(systemName: "person")
                    }
                }
            }
            
        }
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        Recipes()
    }
}
