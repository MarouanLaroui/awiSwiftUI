//
//  IngredientForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct IngredientForm: View {
    
    //@StateObject var ingredientFormView = IngredientFormViewModel(model: Ingredient(name:"",unitaryPrice: 1, nbInStock : 1, ingredientCategory: IngredientCategory.categories[0],  unity: Unity.units[0]))
    @ObservedObject var ingredientFormVM : IngredientFormVM
    @State var ingredientCategories : [IngredientCategory] = []
    @State var allergenCategories :[AllergenCategory] = []
    @State var units : [Unity] = []
    var intent : Intent
    @State var isUpdate = false
    
    init(ingredient : Ingredient?, ingredientsVM : IngredientListVM){
        
        print(ingredient?.name)
        if let ingredient = ingredient{
            print("ingredient non vide")
            self.ingredientFormVM = IngredientFormVM(model: ingredient)
            isUpdate = true
        }
        else{
            /*TO CHANGE TO INIT WITH REAL PROPERTIES*/
            print("pas d'ingredient ?????")
            self.ingredientFormVM = IngredientFormVM(model: Ingredient(name: "", unitaryPrice: 1, nbInStock: 1, ingredientCategory: IngredientCategory.categories[0], unity: Unity.units[0]))
        }
        
        
        self.intent = Intent()
        self.intent.addObserver(viewModel: self.ingredientFormVM)
        self.intent.addListObserver(viewModel: ingredientsVM)
    }
    
    var body: some View {
        NavigationView{
            List{
                VStack{
                    Group{
                        HStack{
                            Text("Nom : ")
                            TextField("",text:$ingredientFormVM.name)
                                .onSubmit {
                                    self.intent.intentToChange(name: self.ingredientFormVM.name)
                                }
                        }
                        Divider()
                    
                        HStack{
                            Text("Prix unitaire : ")
                            TextField("",value : $ingredientFormVM.unitaryPrice, formatter:  Formatters.decimal)
                                .onSubmit {
                                    self.intent.intentToChange(unitaryPrice: self.ingredientFormVM.unitaryPrice)
                                }
                        }
                        Divider()
                    
                        Stepper(value: $ingredientFormVM.unitaryPrice, in:0...200, step:2){
                            //CHANGE THAT TO EURO
                            Label("\(ingredientFormVM.unitaryPrice)",systemImage: "eurosign.circle.fill")
                        }
                        Divider()
                    
                        /*DROPDOWN*/
                        Picker("Catégorie : " + ingredientFormVM.category.category_name, selection: $ingredientFormVM.category) {
                            ForEach(ingredientCategories) { category in
                                Text(category.category_name)
                            }
                        }
                    }
                        
                        .padding(.bottom,5)
                        
                        Divider()
                    
                    Picker("Unité : " + ingredientFormVM.unity.unityName, selection: $ingredientFormVM.unity) {
                            ForEach(units) { unity in
                                Text(unity.unityName)
                            }
                        }
                        .padding(.bottom,5)
                    
                        Divider()
                        Picker("Allergène :", selection: $ingredientFormVM.allergen) {
                            Text("Aucun")
                                .tag(nil as AllergenCategory?)
                            ForEach(allergenCategories) { allergen in
                                Text(allergen.name)
                            }
                        }
                    
                        Divider()
                    Button(" ajouter "){
                    }
                    .padding(10)
                    .background(Color.salmon)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                }
            }
            .navigationTitle("New ingredient")
     
        }
        .task{
            async let reqUnits =  UnityDAO.getUnits()
            
            async let reqCategories = IngredientCategoryDAO.getIngredientCategories()
            
            async let reqAllergens = AllergenCategoryDAO.getAllergenCategories()
            
            switch(await reqUnits){
                
            case .success(let resUnits):
                units = resUnits
            case .failure(let error):
                print(error)
            }
            
            switch(await reqCategories){
                
            case .success(let resIngredientCategories):
                ingredientCategories = resIngredientCategories
            case .failure(let error):
                print(error)
            }
            
            switch(await reqAllergens){
                
            case .success(let resAllergenCategories):
                allergenCategories = resAllergenCategories
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}

struct IngredientForm_Previews: PreviewProvider {
    static var previews: some View {
        IngredientForm(ingredient: nil, ingredientsVM: IngredientListVM(ingredients: Ingredient.ingredients))
    }
}
