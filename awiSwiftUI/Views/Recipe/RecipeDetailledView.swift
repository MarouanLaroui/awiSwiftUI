//
//  RecipeDetailledView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import SwiftUI

struct RecipeDetailledView: View {
    
    var threeColumns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 3)
    var twoColumns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var numEtape = 0
    @State private var showIngredient = true
    @State private var showCosts = false
    @State private var durationTime = 0
    
    @State var ingredients : [Ingredient:Int] = [:]
    @State private var steps : [Step] = []
    @State var recipe : Recipe
    @State var recipeImgStr : String = ""
    
    private func textColor(isSelected : Bool)->Color{
        return isSelected ? Color.salmon : .gray
    }
    private func bgColor(isSelected : Bool)->Color{
        return isSelected ? Color.white : Color.lightgrey
    }
    
    private var editButton: some View {
        return NavigationLink(destination : StepList(recipe: self.recipe, intent: StepIntent())){
            Text("Modifier")
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image(self.recipeImgStr)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                HStack{
                    VStack{
                        Divider()
                        HStack{
                            Spacer()
                         
                            Label("\(durationTime) min", systemImage: "timer")
                                .padding(.horizontal,10)
                            
                            Label("1 euro", systemImage: "eurosign.circle")
                            
                            Label("\(recipe.nbOfServing) p", systemImage: "fork.knife.circle")
                                .padding(.horizontal,10)

                            Spacer()
                        }
                        .padding(.horizontal,40)
                        Divider()
                    }
                    
                }
                
                //Buttons
                HStack{
                    
                    // ----------- Coûts -----------
                    Button(action: {
                        self.showCosts.toggle()
                    })
                    {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Coûts")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.salmon)
                        .cornerRadius(40)
                    }
                    .sheet(isPresented: $showCosts){
                        CostView(recipe: recipe, durationTime: durationTime)
                        
                        Spacer()
                        Button("Fermer") {
                            showCosts.toggle()
                        }
                        .foregroundColor(Color.salmon)
                        .padding()
                        
                        
                    }
                    
                    
                    //----------- Etiquette -----------
                    NavigationLink(destination: LabelManagement(recipe: recipe, ingredients: ingredients)){
                        HStack {
                            Image(systemName: "tag")
                            Text("Etiquette")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.salmon)
                        .cornerRadius(40)
                    }
                    .navigationBarTitle("\(recipe.title)")
                    .navigationBarItems(trailing: editButton)
                    
                }
                
                HStack{
                    HStack{
                        Spacer()
                        Button {
                            self.showIngredient = true
                        } label: {
                            Text("Ingrédients").bold()
                        }
                
                        Spacer()
                    }
                    .padding(5)
                    .background(bgColor(isSelected: showIngredient))
                    .foregroundColor(textColor(isSelected: showIngredient))
                    .cornerRadius(20)
                    
                    
                    HStack{
                        Spacer()
                        Button {
                            self.showIngredient = false
                        } label: {
                            Text("Ustensiles").bold()
                        }
                        Spacer()
                    }
                    .padding(5)
                    .background(bgColor(isSelected: !showIngredient))
                    .foregroundColor(textColor(isSelected: !showIngredient))
                    .cornerRadius(20)
                }
                .padding(3)
                .background(Color.lightgrey)
                .cornerRadius(20)
                .padding(.horizontal)
                
                if(showIngredient){
                    VStack{
                        ForEach(ingredients.sorted(by: ==), id: \.key.id) { ingredient, qtty in
                            HStack{
                                Text(ingredient.name + " -")
                                    .fontWeight(.bold)
                                Text("\(qtty)" + ingredient.unity.unityName)
                            }
                        }
                    }.padding(.horizontal)
                        
                    
                }
                else{
                    HStack{
                        VStack{
                            HStack(){
                                if(recipe.dressingEquipment != ""){
                                    Text("Dressage : ")
                                        .bold()
                                    Text(recipe.dressingEquipment)
                                }
                                else{
                                    Text("Aucun équipement de dressage nécessaire")
                                        .italic()
                                        .opacity(0.75)
                                }

                            }
                            HStack{
                                if(recipe.specificEquipment != ""){
                                    Text("Spécifique : ")
                                        .bold()
                                    Text(recipe.specificEquipment)
                                }
                                else{
                                    Text("Aucun équipement spécifique nécessaire")
                                        .italic()
                                        .opacity(0.75)
                                }
                                
                            }

                        }
                        
                    }
                }
                
                
                Divider()
                HStack{
                    Text("Préparation")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.salmon)
                }
                Divider()
                
                VStack(alignment: .leading){
                    
                    ForEach(Array(zip(steps.indices, steps)), id: \.1) { index, element in
                        StepRow(numEtape: index+1, step: element)
                            .padding(.bottom)
                    }
                }

       
            }
            .navigationTitle(recipe.title)
            
            .background(.white)
            .cornerRadius(10)
        }
        .onAppear{
            self.recipeImgStr = ImageHelper.randomPic()
        }
        .task{            
            let result = await StepDAO.getStepOfRecipe(recipeId: self.recipe.id!)
            let resIngredients = await IngredientDAO.getTotalIngredients(recipeId: self.recipe.id!)
            let resultDuration = await RecipeDAO.getRecipeDuration(id: self.recipe.id!)
        
            //Etapes
            switch(result){
            case .success(let resSteps):
                self.steps = resSteps
            case .failure(let error):
                print("error while retrieving steps" + error.localizedDescription)
            }
            
            //Ingrédients
            switch(resIngredients){
            case .success(let resIngrDict):
                self.ingredients = resIngrDict
            case .failure(let error):
                print("error while retrieving ingredients total" + error.localizedDescription)
            }
            
            //Temps de préparation
            switch(resultDuration){
            case .success(let durationTime):
                self.durationTime = durationTime
            case .failure(let error):
                print("error while retrieving duration time" + error.localizedDescription)
            }
        }
    }
}

struct RecipeDetailledView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeDetailledView(recipe: Recipe.recipes[1])
        }
        
    }
}

