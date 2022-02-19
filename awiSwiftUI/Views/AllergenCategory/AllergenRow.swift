//
//  AllergenRow.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct AllergenRow: View{
    @State var allergen: AllergenCategory
    @State var ingredients: [Ingredient] = []
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                
                //Allergen name
                Text(allergen.name)
                    .font(.title3)
                    .bold()
                
                //Ingredients list associated
                AllergenIngredientsList(allergen: allergen)
                
            }
            .padding()
        }
        
    }
}
