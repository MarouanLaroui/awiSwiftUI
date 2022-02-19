//
//  RecipeGrid.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 09/02/2022.
//

import SwiftUI

struct RecipeGrid: View {
    
    @State var recipes : [Recipe]
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: gridItems,spacing: 0){
                RecipeCard()
                    .frame(width: 170, height: 250)
                RecipeCard()
                    .frame(width: 170, height: 250)
                RecipeCard()
                    .frame(width: 170, height: 250)
                RecipeCard()
                    .frame(width: 170, height: 250)
                RecipeCard()
                    .frame(width: 170, height: 250)
                RecipeCard()
                    .minimumScaleFactor(0.01)
                    .frame(width: 150, height: 250)
            }
      
        }
        
    }
}

struct RecipeGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RecipeGrid(recipes : Recipe.recipes)
                .padding()
        }
        .background(.gray)
    }
}
