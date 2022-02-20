//
//  RecipeDetailledView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import SwiftUI

struct RecipeDetailledView: View {
    
    @State private var showIngredient = true
    
    private func textColor(isSelected : Bool)->Color{
        return isSelected ? Color.salmon : .gray
    }
    private func bgColor(isSelected : Bool)->Color{
        return isSelected ? Color.white : Color.lightgrey
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image("dahl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                HStack{
                    VStack{
                        Divider()
                        HStack{
                            Spacer()
                            
                         
                            Label("10 min", systemImage: "timer")
                                .padding(.horizontal,10)
                            
                            Label("1 euro", systemImage: "eurosign.circle")
                            
                            Label("10 min", systemImage: "timer")
                                .padding(.horizontal,10)

                            Spacer()
                        }
                        .padding(.horizontal,40)
                        Divider()
                    }
                    
                }
                
                HStack{
                    HStack{
                        Spacer()
                        Button {
           
                        } label: {
                            Text("Ingrédients").bold()
                        }
                
                        Spacer()
                    }
                    .padding(5)
                    .background(bgColor(isSelected: showIngredient))
                    .foregroundColor(textColor(isSelected: showIngredient))
                    .cornerRadius(20)
                    
                    HStack{
                        Spacer()
                        Button {
           
                        } label: {
                            Text("Ustensiles").bold()
                        }
                        Spacer()
                    }
                    .padding(5)
                    .background(bgColor(isSelected: !showIngredient))
                    .foregroundColor(textColor(isSelected: !showIngredient))
                    .cornerRadius(20)
                }
                .padding(3)
                .background(Color.lightgrey)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Divider()
                HStack{
                    Text("Préparation")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.salmon)
                }
                Divider()
                
                StepRow(numEtape: 1)
                    .padding(.bottom)
                StepRow(numEtape: 2)
                    .padding(.bottom)
                StepRow(numEtape: 3)
                    .padding(.bottom)
                StepRow(numEtape: 4)
                    .padding(.bottom)
       
            }
            .navigationTitle("Dahl de lentille corail")
            
            .background(.white)
            .cornerRadius(10)
        }
        
    }
}

struct RecipeDetailledView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeDetailledView()
        }
        
    }
}
