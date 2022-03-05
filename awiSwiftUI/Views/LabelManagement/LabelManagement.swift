//
//  Label.swift
//  awiSwiftUI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

struct LabelManagement: View {
    
    @State var recipe: Recipe
    @State var ingredients : [Ingredient:Int] = [:]
    @State private var decrementStock : Bool = false
    @State private var nbPortions = 1
    @State private var enoughIngredients = false
    
    var etiquette: some View {
        VStack{
            Text("\(recipe.title)")
                .font(.largeTitle)
                .bold()
            
            Text("")
            
            Text("Ingrédients : ")
            VStack (alignment: .leading, spacing: 2.0){
                ForEach(ingredients.sorted(by: ==), id: \.key.id) { ingredient,qtty in
                    HStack{
                        Text(ingredient.name)
                        if(ingredient.allergen != nil){
                            Text("("+ingredient.allergen!.name+") ")
                                .fontWeight(.semibold)
                                .italic()
                        }
                    }
                }
            }
            .padding()
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundColor(Color.salmon)
        )
        
        .padding()
        .navigationTitle("Etiquette")
    }
    
    
    var body: some View{
        Spacer()
        VStack {
            
            //Nombre de portions vendues
            HStack{
                Stepper("\(nbPortions.formatted()) portions vendues",
                        value: $nbPortions,
                        in: 1...50,
                        step: 1)
                .padding(.horizontal, 80)
                
            }
            
            //Slider décrémentation des stocks
            HStack{
                Text("Mettre à jour les stocks")
                    .foregroundColor(decrementStock ? Color.salmon : .gray)
                Toggle("Stock", isOn: $decrementStock)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.salmon))
            }
            
        }
        
        etiquette
            
        Spacer()
            
        if decrementStock {
            Text("Les stocks seront décrémentés lors de la capture d'écran.")
                .bold()
                .italic()
                .font(.caption)
                .opacity(0.5)
        }
            
        Button("Prendre une capture d'écran") {
           /* let image = etiquette.snapshot()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            */
            
            Task{
                async let requestEnoughIngredients =  RecipeDAO.declareRecipePost(idRecipe: self.recipe.id!, nbPortion: self.nbPortions)
                
                print(String(enoughIngredients))
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.salmon)
        .cornerRadius(40)
        
        .padding(.bottom, 80)
            
    }
    
}
