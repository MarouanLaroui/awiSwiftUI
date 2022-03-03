//
//  HorizontalScrollRecipes.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct HorizontalScrollRecipes: View {
    
    @State var recipes : [Recipe] = []

    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:20){
                ForEach(recipes){ recipe in
                    RecipeCard(recipe: recipe)
                        .frame(width: 170, height: 240)
                        .shadow(radius: 3)
                }
            }
            
        }
        .task{
            let resultRecipes = await RecipeDAO.getRecipes()
        
            //Recettes
            switch(resultRecipes){
            case .success(let resRecipes):
                self.recipes = resRecipes
                //garder niquement les dernières recettes = fin du tableau
                self.recipes.removeSubrange (0..<self.recipes.count-4)
            case .failure(let error):
                print("error while retrieving recipes" + error.localizedDescription)
            }
        }
        
    }
        
}

/*struct HorizontalScrollRecipes_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollRecipes()
    }
}
*/
