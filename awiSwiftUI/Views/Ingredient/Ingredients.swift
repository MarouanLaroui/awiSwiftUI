//
//  Ingredients.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct Ingredients: View {
    
    @ObservedObject var ingredientsVM : IngredientListVM = IngredientListVM(ingredients: [])
    var intent : Intent
    @State private var selectedIngredientIndex : Int = 0
    @State private var selectedIngredient : Ingredient? = nil
    @State var ingredientCategories : [IngredientCategory] = []
    @State var searchedIngredientName = ""
    @State var isFormDisplayed = false
    @State var isAlertShowed = false
    @State var selectedCategory : IngredientCategory? = nil
    @State var isDataLoading : Bool = false
    
    init(){
        print("--------init ingredients-------")
        self.intent = Intent()
        self.intent.addListObserver(viewModel: ingredientsVM)
    }
    
    var searchResult : [Ingredient]{
        if(searchedIngredientName.isEmpty){
            return ingredientsVM.ingredients;
        }
        return ingredientsVM.ingredients.filter({$0.name.contains(searchedIngredientName)})
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
            //List(ingredientsVM.ingredients.indices){
              //  ingredientIndex in
            List(ingredientsVM.ingredients){
                ingredient in
                IngredientRow(ingredientVM: IngredientFormVM(model: ingredient))
                    .swipeActions {
                        Button {
                            //self.selectedIngredientIndex = ingredientIndex
                            
                            selectedIngredient = ingredient
                            isFormDisplayed = true
                        }
                        label: {
                            Image(systemName: "square.and.pencil")
                        }
                
                        Button {
                            self.isAlertShowed = true
                            Task{
                                await self.intent.intentToDeleteIngredient(ingredientId: ingredient.id!)
                            }
            
                        }
                        label: {
                            Image(systemName: "trash")
                        }
                        .background(Color.red)
                        /*
                        .alert("Delete ?", isPresented: $isAlertShowed) {
                            Button(role: .cancel) {
                            } label: {
                                Text("No")
                            }
                            Button(role: .destructive) {
                                self.isAlertShowed = false
                                // TODO: intentToRemoveIngredient
                            } label: {
                                Text("Yes")
                                
                            }
                        }
                         */
                    }
            }
             
            
            /*
            .searchable(text: $searchedIngredientName,placement: .navigationBarDrawer(displayMode: .always))
            
        }
        */
        }
        .onAppear{
            Task{
                if(self.ingredientsVM.ingredients.count == 0 && self.ingredientCategories.count == 0){
                    
                    print("request un on appeare")
//                        print("before post")
//                        await IngredientDAO.postIngredientTest()
//                        print("after post")

//                        isDataLoading = true

                    let reqIngredients = await IngredientDAO.getIngredients()
                    let reqCategories = await IngredientCategoryDAO.getIngredientCategories()
                    
                    switch( reqIngredients){
                        
                    case .success(let resIngredients):
                        ingredientsVM.ingredients = resIngredients
                        print("sucess ingredient")
                    case .failure(let error):
                        print(error)
                    }
                    
                    switch( reqCategories){
                        
                    case .success(let resIngredientCategories):
                        ingredientCategories = resIngredientCategories
                        print("success category")
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        .overlay(
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button("+"){
                        isFormDisplayed.toggle()
                        selectedIngredient = nil
                    }
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
        
        .sheet(isPresented: $isFormDisplayed){
            if let selectedIngredient = selectedIngredient {
                IngredientForm(ingredientVM: IngredientFormVM(model: selectedIngredient), intent : self.intent, isFormDisplayed: $isFormDisplayed)
                //IngredientForm(ingredientVM: IngredientFormVM(model: ingredientsVM.ingredients[selectedIngredientIndex]), ingredientsVM: ingredientsVM)
            }
            else{
                IngredientForm(ingredientVM : nil, intent: self.intent, isFormDisplayed: $isFormDisplayed)
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

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            Ingredients()
        }
        
    }
}
