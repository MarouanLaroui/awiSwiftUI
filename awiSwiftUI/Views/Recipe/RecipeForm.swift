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
            
            VStack(alignment: .leading){
                Group{
                    TextField("Titre de la recette", text: $recipeFormVM.title)
                        .onSubmit {
                            self.intent.intentToChange(title: self.recipeFormVM.title)
                        }
                        .underlineTextField(color: .gray)
                        .padding(.bottom, 5)
                    
                    HStack{
                        Image(systemName: "figure.wave")
                        TextField("Responsable", text: $recipeFormVM.personInCharge)
                            .onSubmit {
                                self.intent.intentToChange(personInCharge: self.recipeFormVM.personInCharge)
                            }
                            .underlineTextField(color: .gray)
                    }
                    
                    .padding(.bottom, 5)
                    
                    HStack{
                        Image(systemName: "fork.knife")
                        TextField("Nombre de portions", value: $recipeFormVM.nbOfServing, formatter: Formatters.int)
                            .onSubmit {
                                self.intent.intentToChange(nbOfServing: self.recipeFormVM.nbOfServing)
                            }
                            .underlineTextField(color: .gray)
                    }
                    
                    .padding(.bottom, 5)
                    
                    TextField("Outils de dressage", text: $recipeFormVM.dressingEquipment)
                        .onSubmit {
                            self.intent.intentToChange(dressingEquipment: self.recipeFormVM.dressingEquipment)
                        }
                        .underlineTextField(color: .gray)
                        .padding(.bottom, 5)
                    
                    TextField("Equipement spécifique", text: $recipeFormVM.specificEquipment)
                        .onSubmit {
                            self.intent.intentToChange(specificEquipment: self.recipeFormVM.specificEquipment)
                        }
                        .underlineTextField(color: .gray)
                        .padding(.bottom, 5)
                }
                
                Group{
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
                Spacer()
                
            }
            .navigationTitle("Nouvelle recette")
            .padding(30)
            
            Spacer()
            
            Button("Enregistrer"){
                Task{
                    let res = await self.intent.intentToCreateRecipe(recipe: self.recipeFormVM.model)
                
                    switch(res){
                        
                    case .success(let postedRecipe):
                        self.presentationMode.wrappedValue.dismiss()
                        
                    case .failure(_):
                        print("failure in steplist view")
                    }
                }
            }
            .padding(10)
            .background(Color.salmon)
            .foregroundColor(.white)
            .cornerRadius(15)
            
            Spacer()
        }
        .task {
            let res = await RecipeCategoryDAO.getRecipeCategories()
            
            switch(res){
                
            case .success(let categories):
                self.recipeFormVM.RecipeChange(recipeCategory: categories[0])
                self.recipeCategories = categories

            case .failure(_):
                print("recipeCategory query failure")
            }
        }
    }
}
