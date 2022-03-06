//
//  RecipeForm.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import SwiftUI

struct RecipeForm: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                    TextField("Title", text: $recipeFormVM.title)
                        .onSubmit {
                            self.intent.intentToChange(title: self.recipeFormVM.title)
                        }
                    
                    Text("Person in charge :")
                    TextField("Person in charge", text: $recipeFormVM.personInCharge)
                        .onSubmit {
                            self.intent.intentToChange(personInCharge: self.recipeFormVM.personInCharge)
                        }
                    
                    
                    Text("Number of serving :")
                    TextField("Number of serving", value: $recipeFormVM.nbOfServing, formatter: Formatters.int)
                        .onSubmit {
                            self.intent.intentToChange(nbOfServing: self.recipeFormVM.nbOfServing)
                        }
                    
                    Text("Dressing equipment :")
                    TextField("Dressing equipment", text: $recipeFormVM.dressingEquipment)
                        .onSubmit {
                            self.intent.intentToChange(dressingEquipment: self.recipeFormVM.dressingEquipment)
                        }
                    Text("Specific equipment :")
                    TextField("Specific equipment", text: $recipeFormVM.specificEquipment)
                        .onSubmit {
                            self.intent.intentToChange(specificEquipment: self.recipeFormVM.specificEquipment)
                        }
                }
                
                HStack{
                    Text("Catégorie :")
                    
                    Picker("", selection: $recipeFormVM.recipeCategory) {
                        if(self.recipeFormVM.id != nil){
                            Text(self.recipeFormVM.recipeCategory!.name)
                        }
                        else{
                            Text("Aucun")
                                .tag(nil as IngredientCategory?)
                        }
                        ForEach(recipeCategories) { category in
                            Text(category.name).tag(category as RecipeCategory?)
                        }
                    }
                    .onReceive([self.recipeFormVM.recipeCategory].publisher.first()) { (recipeCategory) in
                        self.intent.intentToChange(recipeCategory: recipeCategory)
                    }
                }
                
            }
            .navigationTitle("Create Recipe")
            .padding()
            
            
            
            
            
            Button("Create recipe"){
                Task{
                    let res = await self.intent.intentToCreateRecipe(recipe: self.recipeFormVM.model)
                
                    switch(res){
                        
                    case .success(let postedRecipe):
                        print("success create recipe in view")
                        self.presentationMode.wrappedValue.dismiss()
                        
                    case .failure(_):
                        print("failure in steplist view")
                    }
                }
            }
            /*
            NavigationLink(destination: StepList(recipeIntent: self.intent, recipeModel: self.recipeFormVM.model, previousPagePresentationMode: presentationMode)){
                Text("Add steps")
                    .padding()
                    .background(Color.salmon)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
             */
            Spacer()
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
