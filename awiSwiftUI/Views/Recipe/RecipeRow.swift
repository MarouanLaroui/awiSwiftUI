//
//  RecipeRow.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import SwiftUI

struct RecipeRow: View {
    
    var gridItems = [GridItem(.fixed(120)),GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: gridItems){
            Image("dahl")
                .resizable()
                .aspectRatio(contentMode: .fit)
        
            VStack(){
                HStack(){
                    Text("Dahl lentille corail")
                    Spacer()
                }
                HStack{
                    TextUnderIconView(systemImageStr: "timer", text: "10mn")
              
                    TextUnderIconView(systemImageStr: "eurosign.circle", text: "1 euro")
                        
                    TextUnderIconView(systemImageStr: "timer", text: "10mn")
                }
                HStack{
                    
                }
            }
        }
        .padding()
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow()
    }
}
