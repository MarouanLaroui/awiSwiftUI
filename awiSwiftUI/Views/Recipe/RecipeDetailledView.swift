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
                        //Table des coûts
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
                    HStack{
                        VStack{
                            ForEach(ingredients.sorted(by: ==), id: \.key.id) { ingredient, qtty in
                                HStack{
                                    Text(ingredient.name + " : ")
                                    Text("\(qtty)")
                                }
                            }
                        }
                        
                    }
                }
                else{
                    HStack{
                        VStack{
                            HStack(){
                                Text("équipement de dressage : ")
                                    .bold()
                                Text(recipe.dressingEquipment)

                            }
                            HStack{
                                Text("équipement spécifique")
                                    .bold()
                                Text(recipe.specificEquipment)
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
                
                ForEach(steps){
                    step in
                    StepRow(numEtape: 1,step: step)
                        .padding(.bottom)
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

