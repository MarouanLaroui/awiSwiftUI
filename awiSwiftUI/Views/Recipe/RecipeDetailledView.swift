//
//  RecipeDetailledView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import SwiftUI

struct RecipeDetailledView: View {
    
    @State private var showIngredient = true
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
                            
                         
                            Label("10 min", systemImage: "timer")
                                .padding(.horizontal,10)
                            
                            Label("1 euro", systemImage: "eurosign.circle")
                            
                            Label("10 min", systemImage: "timer")
                                .padding(.horizontal,10)

                            Spacer()
                        }
                        .padding(.horizontal,40)
                        Divider()
                    }
                    
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
        
            switch(result){
                
            case .success(let resSteps):
                self.steps = resSteps
            
            case .failure(let error):
                print("error while retrieving steps" + error.localizedDescription)
            }
            
            switch(resIngredients){
            case .success(let resIngrDict):
                self.ingredients = resIngrDict
            case .failure(let error):
                print("error while retrieving ingredients total" + error.localizedDescription)
            }
        }
    }
}
/*
struct RecipeDetailledView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeDetailledView()
        }
        
    }
}
*/
