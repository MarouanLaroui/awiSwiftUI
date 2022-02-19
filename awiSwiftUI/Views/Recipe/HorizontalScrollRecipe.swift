//
//  HorizontalScrollRecipes.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct HorizontalScrollRecipes: View {

    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:20){
                ForEach(1..<4){ in_ in
                    RecipeCard()
                        .frame(width: 170, height: 240)
                        .shadow(radius: 3)
                }
            }
            
        }
    }
}

struct HorizontalScrollRecipes_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollRecipes()
    }
}
