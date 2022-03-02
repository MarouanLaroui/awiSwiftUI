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
    var intent : RecipeIntent = RecipeIntent()
    
    init(recipeVM : RecipeVM){
        self.recipeFormVM = recipeVM
        self.intent.addObserver(viewModel: recipeFormVM)
    }
    
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    
    var body: some View {
        
        VStack{
            
            LazyVGrid(columns: gridItems, alignment : .leading){
                Group{
                    Text("Title")
                    TextField("", text: $recipeFormVM.title)
                        .onSubmit {
                            self.intent.intentToChange(title: self.recipeFormVM.title)
                        }
                    
                    Text("Person in charge :")
                    TextField("", text: $recipeFormVM.personInCharge)
                        .onSubmit {
                            self.intent.intentToChange(personInCharge: self.recipeFormVM.personInCharge)
                        }
                    
                    
                    Text("Number of serving :")
                    TextField("", value: $recipeFormVM.nbOfServing, formatter: Formatters.int)
                        .onSubmit {
                            self.intent.intentToChange(nbOfServing: self.recipeFormVM.nbOfServing)
                        }
                    
                    Text("Dressing equipment :")
                    TextField("", text: $recipeFormVM.dressingEquipment)
                        .onSubmit {
                            self.intent.intentToChange(dressingEquipment: self.recipeFormVM.dressingEquipment)
                        }
                    Text("Specific equipment :")
                    TextField("", text: $recipeFormVM.specificEquipment)
                        .onSubmit {
                            self.intent.intentToChange(specificEquipment: self.recipeFormVM.specificEquipment)
                        }
                }
                
                Text("Recipe category :")
                /*DROPDOWN*/
                
                
            }
            .navigationTitle("Create Recipe")
            .padding()
            
            Picker("Catégorie : ", selection: $recipeFormVM.recipeCategory) {
                ForEach(recipeCategories) { category in
                    Text(category.name)
                }
            }

            NavigationLink(destination: StepList(recipeIntent: self.intent)){
                Text("Add steps")
                    .padding()
                    .background(Color.salmon)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
        }
        .task {
            let res = await RecipeCategoryDAO.getRecipeCategories()
            
            switch(res){
                
            case .success(let categories):
                print("success retrieving categories")
                self.recipeFormVM.RecipeChange(recipeCategory: categories[0])
                self.recipeCategories = categories

            case .failure(_):
                print("recipeCategory query failure")
            }
        }
    }
}

/*
struct RecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeForm(recipeFormVM: RecipeVM(model: Recipe.recipes[0]), recipeCategories: [])
        }
    }
}
*/
