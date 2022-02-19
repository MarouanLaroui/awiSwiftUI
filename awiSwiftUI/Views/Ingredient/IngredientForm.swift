//
//  IngredientForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct IngredientForm: View {
    
    @StateObject var ingredientFormView = IngredientFormViewModel(model: Ingredient(name:"",unitaryPrice: 1, nbInStock : 1, ingredientCategory: IngredientCategory.categories[0],  unity: Unity.units[0]))
    
    @State var ingredientCategories : [IngredientCategory] = []
    @State var allergenCategories :[AllergenCategory] = []
    @State var units : [Unity] = []
    
    
    var body: some View {
        NavigationView{
            List{
                VStack{
                    Group{
                        HStack{
                            Text("Nom : ")
                            TextField("",text:$ingredientFormView.name)
                        }
                        Divider()
                    
                        HStack{
                            Text("Prix unitaire : ")
                            TextField("",value : $ingredientFormView.unitaryPrice, formatter:  Formatters.decimal)
                        }
                        Divider()
                    
                        Stepper(value: $ingredientFormView.unitaryPrice, in:0...200, step:2){
                            //CHANGE THAT TO EURO
                            Label("\(ingredientFormView.unitaryPrice)",systemImage: "eurosign.circle.fill")
                        }
                        Divider()
                    
                        /*DROPDOWN*/
                        Picker("Catégorie : " + ingredientFormView.ingredientCategory.category_name, selection: $ingredientFormView.ingredientCategory) {
                            ForEach(ingredientCategories) { category in
                                Text(category.category_name)
                            }
                        }
                    }
                        
                        .padding(.bottom,5)
                        
                        Divider()
                    
                        Picker("Unité : "+ingredientFormView.unity.unityName, selection: $ingredientFormView.unity) {
                            ForEach(units) { unity in
                                Text(unity.unityName)
                            }
                        }
                        .padding(.bottom,5)
                    
                        Divider()
                        Picker("Allergène :", selection: $ingredientFormView.allergenCategory) {
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
            async let reqCategories = IngredientCategoryDAO.getIngredientCategories()
            async let reqAllergens = AllergenCategoryDAO.getAllergens()
            async let reqUnits = UnityDAO.getUnits()
            
            if let categories = await reqCategories{
                ingredientCategories = categories
            }
            
            if let allergens = await reqAllergens{
                allergenCategories = allergens
            }
            
            if let unitsCategories = await reqUnits{
                units = unitsCategories
            }
        }
        
        
    }
}

struct IngredientForm_Previews: PreviewProvider {
    static var previews: some View {
        IngredientForm()
    }
}
