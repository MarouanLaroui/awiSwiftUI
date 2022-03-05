//
//  IngredientForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct IngredientForm: View {
    
    @ObservedObject var ingredientFormVM : IngredientFormVM
    @State var ingredientCategories : [IngredientCategory] = []
    @State var allergenCategories :[AllergenCategory] = []
    @State var units : [Unity] = []
    @Binding var isFormDisplayed : Bool
    var intent : Intent
    @State var isUpdate = false
    
    
    
    init(ingredientVM : IngredientFormVM?, intent : Intent, isFormDisplayed : Binding<Bool>){
        
        if let ingredientVM = ingredientVM{
            self.ingredientFormVM = ingredientVM
            isUpdate = true
        }
        else{
            self.ingredientFormVM = IngredientFormVM(model: Ingredient(name: "", unitaryPrice: 1, nbInStock: 1, ingredientCategory: IngredientCategory.categories[0], unity: Unity.units[0]))
        }
        self._isFormDisplayed = isFormDisplayed
        
        self.intent = intent
        self.intent.addObserver(viewModel: self.ingredientFormVM)
        
    }
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                Text("Formulaire ingrédient")
                    .font(.title)
                    .bold()
                    .padding(.vertical)
                
                Group{
                    TextField("nom :",text:$ingredientFormVM.name)
                        .onSubmit {
                            self.intent.intentToChange(name: self.ingredientFormVM.name)
                        }
                        .underlineTextField(color: .gray)
                    
                    HStack{
                        Text(self.ingredientFormVM.nameErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                }
                
                Group{
                    TextField("unitary price",value : $ingredientFormVM.unitaryPrice, formatter:  Formatters.decimal)
                        .onSubmit {
                            self.intent.intentToChange(unitaryPrice: self.ingredientFormVM.unitaryPrice)
                        }
                        .underlineTextField(color: .gray)
                    
                    HStack{
                        Text(self.ingredientFormVM.unitaryPriceErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                }
                /*
                 Group{
                 Stepper(value: $ingredientFormVM.unitaryPrice, in:0...200, step:2){
                 //CHANGE THAT TO EURO
                 Label("\(ingredientFormVM.unitaryPrice)",systemImage: "eurosign.circle.fill")
                 }
                 }
                 */
                Group{
                    /*DROPDOWN*/
                    HStack{
                        Text("Catégorie :")
                        Picker("Catégorie : ", selection: $ingredientFormVM.category) {
                            Text("Aucun")
                                .tag(nil as IngredientCategory?)
                            ForEach(ingredientCategories) { category in
                                Text(category.category_name)
                            }
                        }
                        Spacer()
                    }
                    Text(self.ingredientFormVM.categoryErrorMsg)
                        .font(.caption)
                        .foregroundColor(.red)
                    
                }
                
                Group{
                    HStack{
                        Text("Unité :")
                        Picker("Unité : ", selection: $ingredientFormVM.unity) {
                            Text("Aucun")
                                .tag(nil as Unity?)
                            ForEach(units) { unity in
                                Text(unity.unityName)
                            }
                        }
                        Spacer()
                    }
                    Text(self.ingredientFormVM.unityErrorMsg)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                
                Group{
                    HStack{
                        Text("Allergène :")
                        Picker("Allergène :", selection: $ingredientFormVM.allergen) {
                            Text("Aucun")
                                .tag(nil as AllergenCategory?)
                            ForEach(allergenCategories) { allergen in
                                Text(allergen.name)
                            }
                        }
                        Spacer()
                    }
                }
                
            }
            
            
        }
        HStack{
            Button("Annuler"){
                self.isFormDisplayed = false
            }
            .padding(10)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            Button("Ajouter"){
                if(ingredientFormVM.isValid){
                    Task{
                        await self.intent.intentToCreateIngredient(ingredient : ingredientFormVM.copy, isUpdate: isUpdate)
                        self.isFormDisplayed = false
                    }
                }
                
            }
            .padding(10)
            .background(Color.salmon)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .task{
            print("-------IngredientFORM TASK----------------")
            async let reqUnits =  UnityDAO.getUnits()
            
            async let reqCategories = IngredientCategoryDAO.getIngredientCategories()
            
            async let reqAllergens = AllergenCategoryDAO.getAllergenCategories()
            
            switch(await reqUnits){
                
            case .success(let resUnits):
                print("Success unit")
                units = resUnits
                self.intent.intentToChange(unity: units[0])
            case .failure(let error):
                print(error)
            }
            
            switch(await reqCategories){
                
            case .success(let resIngredientCategories):
                print("Success ingredientCategory")
                ingredientCategories = resIngredientCategories
                self.intent.intentToChange(ingredientCategory: ingredientCategories[0])
                
            case .failure(let error):
                print(error)
            }
            
            switch(await reqAllergens){
                
            case .success(let resAllergenCategories):
                print("Success allergenCategory")
                allergenCategories = resAllergenCategories
            case .failure(let error):
                print(error)
            }
        }
        Spacer()
        
        
        
    }
    
}
/*
 struct IngredientForm_Previews: PreviewProvider {
 static var previews: some View {
 IngredientForm(ingredientVM: nil, ingredientsVM: IngredientListVM(ingredients: Ingredient.ingredients))
 }
 }
 */


/*
 
 List{
 VStack{
 
 Group{
 VStack{
 HStack{
 Text("Nom : ")
 TextField("nom :",text:$ingredientFormVM.name)
 .onSubmit {
 self.intent.intentToChange(name: self.ingredientFormVM.name)
 }
 }
 Text("erreur")
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
 
 }
 }
 .navigationTitle("New ingredient")
 
 */
