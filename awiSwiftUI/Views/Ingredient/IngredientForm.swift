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
        VStack{
            
            VStack (alignment: .leading){
                
                if(ingredientFormVM.name == ""){
                    Text("Ajouter un ingrédient")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                }
                else {
                    Text("Modifier un ingrédient")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                }

                Group{
                    TextField("Nom de l'ingrédient",text:$ingredientFormVM.name)
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
                    HStack{
                        Image(systemName: "eurosign.circle")
                        TextField("Prix unitaire",value : $ingredientFormVM.unitaryPrice, formatter:  Formatters.decimal)
                            .onSubmit {
                                self.intent.intentToChange(unitaryPrice: self.ingredientFormVM.unitaryPrice)
                            }
                            .underlineTextField(color: .gray)
                    }
                    
                    HStack{
                        Text(self.ingredientFormVM.unitaryPriceErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                }
                
                Group{
                    // -- Catégorie --
                    HStack{
                        Text("Catégorie :")
                        Picker("Catégorie : ", selection: $ingredientFormVM.category) {
                            if(self.ingredientFormVM.copy.id != nil){
                                Text(self.ingredientFormVM.category!.category_name)
                                .foregroundColor(.salmon)
                            }
                            else{
                                Text("Aucun")
                                    .tag(nil as IngredientCategory?)
                                    .foregroundColor(.salmon)
                            }
                            ForEach(ingredientCategories) { category in
                                Text(category.category_name).tag(category as IngredientCategory?)
                            }
                        }
                        .onReceive([self.ingredientFormVM.category].publisher.first()) { (category) in
                            self.intent.intentToChange(ingredientCategory: category)
                        }
                
                        Spacer()
                    }
                    HStack{
                        Text(self.ingredientFormVM.categoryErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                    //-- Unité --
                    HStack{
                        Text("Unité :")
                        Picker("Unité : ", selection: $ingredientFormVM.unity) {
                            if(self.ingredientFormVM.copy.id != nil){
                                Text(self.ingredientFormVM.unity!.unityName)
                            }
                            else{
                                Text("Aucun")
                                    .tag(nil as Unity?)
                            }
                            ForEach(units) { unity in
                                Text(unity.unityName).tag(unity as Unity?)
                            }
                        }
                        .onReceive([self.ingredientFormVM.unity].publisher.first()) { (unity) in
                            self.intent.intentToChange(unity: unity)
                        }
                        Spacer()
                    }
                    HStack{
                        Text(self.ingredientFormVM.unityErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                    
                    //-- Allergène --
                    HStack{
                        Text("Allergène :")
                        Picker("Allergène :", selection: $ingredientFormVM.allergen) {
                            if(self.ingredientFormVM.copy.id != nil && self.ingredientFormVM.allergen != nil){
                                Text(self.ingredientFormVM.allergen!.name)
                            }
                            else{
                                Text("Aucun")
                                    .tag(nil as IngredientCategory?)
                            }
                            ForEach(allergenCategories) { allergen in
                                Text(allergen.name).tag(allergen as AllergenCategory?)
                            }
                        }
                        .onReceive([self.ingredientFormVM.allergen].publisher.first()) { (allergen) in
                            self.intent.intentToChange(allergenCategory: allergen)
                        }
                    }
                }
                Spacer()
            }
            Spacer()
            
        }
        .padding(30)

        Spacer()
        
        HStack{
            Button("Annuler"){
                self.isFormDisplayed = false
            }
            .padding(10)
            .foregroundColor(.salmon)
            .cornerRadius(10)
            
            Button("Ajouter"){
                self.ingredientFormVM.fieldAreNotDefault()
                
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
        .padding(.bottom, 20)
        .task{
            async let reqUnits =  UnityDAO.getUnits()
            async let reqCategories = IngredientCategoryDAO.getIngredientCategories()
            async let reqAllergens = AllergenCategoryDAO.getAllergenCategories()
            
            //Unités
            switch(await reqUnits){
            case .success(let resUnits):
                units = resUnits
            case .failure(let error):
                print(error)
            }
            
            //Catégories
            switch(await reqCategories){
            case .success(let resIngredientCategories):
                ingredientCategories = resIngredientCategories
                
            case .failure(let error):
                print(error)
            }
            
            //Allergènes
            switch(await reqAllergens){
            case .success(let resAllergenCategories):
                allergenCategories = resAllergenCategories
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
