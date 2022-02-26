//
//  RecipeForm.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import SwiftUI

struct RecipeForm: View {
    
    @ObservedObject var recipeFormVM : RecipeVM
    @State var recipeCategories : [RecipeCategory] = []
    
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    
    var body: some View {
        
        VStack{
            LazyVGrid(columns: gridItems, alignment : .leading){
                Group{
                    Text("Title")
                    TextField("", text: $recipeFormVM.title)
                    Text("Person in charge :")
                    TextField("", text: $recipeFormVM.personInCharge)
                    Text("Number of serving :")
                    TextField("", value: $recipeFormVM.nbOfServing, formatter: Formatters.int)
                    Text("Dressing equipment :")
                    TextField("", text: $recipeFormVM.dressingEquipment)
                    Text("Specific equipment :")
                    TextField("", text: $recipeFormVM.specificEquipment)
                }
                
                Text("Recipe category :")
                /*DROPDOWN*/
                Picker("Catégorie : " + recipeFormVM.recipeCategory.name, selection: $recipeFormVM.recipeCategory) {
                    ForEach(recipeCategories) { category in
                        Text(category.name)
                    }
                }
                
            }
            .navigationTitle("Create Recipe")
            .padding()
            
            Picker("Catégorie : ", selection: $recipeFormVM.recipeCategory) {
                ForEach(recipeCategories) { category in
                    Text(category.name)
                }
            }

            
            Text("Add steps")
                .padding()
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .task {
            let res = await RecipeCategoryDAO.getRecipeCategories()
            
            switch(res){
                
            case .success(let categories):
                print("success retrieving categories")
                self.recipeCategories = categories
                print(self.recipeCategories[0])
            case .failure(_):
                print("recipeCategory query failure")
            }
        }
    }
}

struct RecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeForm(recipeFormVM: RecipeVM(model: Recipe.recipes[0]), recipeCategories: [])
        }
    }
}
