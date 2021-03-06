//
//  RecipeCard.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import SwiftUI

struct RecipeCard: View {
    
    @StateObject var recipe : Recipe
    @State private var durationTime = 0
    
    var body: some View {
        Group{
            VStack{
                HStack{
                    Image(ImageHelper.randomPic())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                HStack{
                    VStack{
                        HStack{
                            Text(recipe.title)
                                .font(.title3)
                                .minimumScaleFactor(0.01)
                        }
                        .padding(.horizontal,5)
                        HStack{
                            
                            Badge(backgroundColor: .red, fontColor: .white, text: "allergenic")
                                .minimumScaleFactor(0.01)
                        }
                        .padding(.bottom,2)
                        HStack{
                            TextUnderIconView(systemImageStr: "timer", text: "\(durationTime)mn")
                      
                            TextUnderIconView(systemImageStr: "eurosign.circle", text: "1 euro")
                     
                            TextUnderIconView(systemImageStr: "fork.knife.circle", text: "\(recipe.nbOfServing) p")
                        
                        }
                        .padding(.bottom)
                    }
                }
            }
            
            .background(Color("AdaptativeColor"))
            .cornerRadius(10)
            
        }
        .shadow(radius: 2)
        .task {
            let result = await RecipeDAO.getRecipeDuration(id: self.recipe.id!)
        
            switch(result){
                
            case .success(let durationTime):
                self.durationTime = durationTime
            
            case .failure(let error):
                print("error while retrieving duration time" + error.localizedDescription)
            }
        }
    }
    
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RecipeCard(recipe: Recipe.recipes[0])
                //.shadow(radius: 5)
                .padding()
        }
        .background(.white)
        
    }
}
