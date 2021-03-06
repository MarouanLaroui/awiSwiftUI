//
//  HomeView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack(alignment:.leading){
  
            Text("Fonctionnalités")
                .font(.title2)
                .bold()
            
            Carousel()
            
            Text("Dernières recettes")
                .font(.title2)
                .bold()
            
            HorizontalScrollRecipes()
            
            Spacer()
        }
        .padding()
        .toolbar {
            HStack{
                NavigationLink(destination: UserAccountView()){
                    HStack {
                        Image(systemName: "person")
                    }
                }
            }
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
       
    }
}
