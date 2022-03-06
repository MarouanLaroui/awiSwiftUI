//
//  LoggedInView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 06/03/2022.
//

import SwiftUI

struct LoggedInView: View {
    var body: some View {
        TabView{
            //TODO :  mettre un . quelque chose pour résoudre les contraintes doubles
            NavigationView{
                HomeView()
                    .navigationTitle("Accueil, bienvenue !")

            }
            .tabItem{
                Image(systemName: "house")
                Text("Home")
            }
            .tint(Color("Salmon"))
            
            NavigationView{
                Allergens()
                    .navigationTitle("Allergènes")
            }
            .tabItem{
                Image(systemName: "cross.fill")
                Text("Allergènes")
            }
            
            
            NavigationView{
                Ingredients()
                    .navigationTitle("Ingrédients")
            }
            .tabItem{
                Image(systemName: "applelogo")
                Text("Ingrédients")
            }
            
            
            NavigationView{
                Recipes()
                    .navigationTitle("Recettes")
            }
            .tabItem{
                Image(systemName: "text.book.closed")
                Text("Recettes")
            }
            
            
            NavigationView{
                Users()
                    .navigationTitle("Utilisateurs")
            }
            .tabItem{
                Image(systemName: "person.circle")
                Text("Utilisateurs")
            }
        }
        .accentColor(.salmon)
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}
