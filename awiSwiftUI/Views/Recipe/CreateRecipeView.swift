//
//  CreateRecipeView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 15/02/2022.
//

import SwiftUI

struct CreateRecipeView: View {
    
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    //var steps : [Stepable] = [Recipe.recipes[0],S]
    var body: some View {
        LazyVGrid(columns: gridItems, alignment : .leading){
            Text("Titre :")
            Text("e ")

            Text("Description :")
            Text("fefefef")
            
            Text("Nombre de couverts :")
            Text("ffefee")
            
            Text("Responsable :")
            Text(" ")
        }
        .padding()
        /*
        VStack{
            HStack{
                Text("Titre :")
                //TextField("", text: $title)
            }
            HStack{
                Text("Description :")
                //TextField("",text: $description)
            }
            HStack{
                Text("Nombre de couverts :")
            }
            HStack{
                Text("Responsable :")
            }
        }
         */
        .navigationTitle("Créer une recette")
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CreateRecipeView()
        }

    }
}
