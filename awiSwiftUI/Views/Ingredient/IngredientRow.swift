//
//  IngredientRow.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct IngredientRow: View {
    @State var ingredient : Ingredient
    var body: some View {
        
        HStack(){
            VStack(alignment : .leading){
                Text(ingredient.name)
                    .font(.title3)
                    .bold()
                    .minimumScaleFactor(0.01)
                HStack{
                    Text("prix unitaire : " + "\(ingredient.unitaryPrice)" + " E/" + ingredient.unity.unityName)
                        .minimumScaleFactor(0.01)
                        .font(.caption)
                }
            }
            .padding()
            if(ingredient.allergen != nil){
                Badge(backgroundColor: Color.red, fontColor: .white, text: "Allergène")
                    .minimumScaleFactor(0.01)
            }
    
        }
        
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(ingredient : Ingredient.ingredients[0])
    }
}
