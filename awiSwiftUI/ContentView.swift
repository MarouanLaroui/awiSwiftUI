//
//  ContentView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 19/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoggedIn : Bool = true
    
    var body: some View {
        /*if(!isLoggedIn){
            LoginView(isLoggedIn: $isLoggedIn)
        }
        else{*/
            TabView{
                //TODO :  mettre un . quelque chose pour résoudre les contraintes doubles
                NavigationView{
                    HomeView()
                        .navigationTitle("ACCUEIL")

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
        //LoginView()
        //Badge(backgroundColor: Color.red, fontColor: Color.white, text: "Allergen")
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
