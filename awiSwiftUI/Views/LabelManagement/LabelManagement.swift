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
    
    var etiquette: some View {
        VStack{
            Text("Etiquette")
                .font(.title)
            Text("Ouais ouais les étiquettes ouais")
            
            ForEach(ingredients.sorted(by: ==), id: \.key.id) { ingredient, qtty in
                HStack{
                    Text(ingredient.name)
                    if(ingredient.allergen != nil){
                        Text(" ("+ingredient.allergen!.name+") ")
                            .fontWeight(.semibold)
                            .italic()
                    }
                }
            }

        }
        .navigationTitle("Etiquette")
    }
    var body: some View{
        etiquette
        
       /* VStack {
            etiquette

            Button("Save to image") {
                let image = etiquette.snapshot()

                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        */
        
    }
}
