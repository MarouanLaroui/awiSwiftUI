//
//  IngredientRow.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct IngredientRow: View {
    
    @ObservedObject var ingredientVM : IngredientFormVM
    
    var body: some View {
        
        HStack(){
            VStack(alignment : .leading){
                Text(ingredientVM.name)
                    .font(.title3)
                    .bold()
                    .minimumScaleFactor(0.01)
                HStack{
                    Text("Prix unitaire : " + "\(ingredientVM.unitaryPrice)" + " €/" + ingredientVM.unity!.unityName)
                        .minimumScaleFactor(0.01)
                        .font(.caption)
                }
                Text("Stock : "+"\(ingredientVM.nbInStock)"+" \(ingredientVM.unity!.unityName)")
                    .font(.caption)
            }
            .padding()
            Spacer()
            if(ingredientVM.allergen != nil){
                Badge(backgroundColor: Color.red, fontColor: .white, text: "Allergène")
                    .minimumScaleFactor(0.01)
                    .padding(.horizontal)
            }
    
        }
        
    }
}
