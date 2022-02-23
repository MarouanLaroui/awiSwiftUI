//
//  IOSawiApp.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//
import SwiftUI

@main
struct IOSawiApp: App {
    
    @State var isLoggedIn : Bool = false
    
    var body: some Scene {
//        if(!isLoggedIn){
//            HomeView(isLoggedIn : $isLoggedIn)
//        }
//        else{
//
//        }
        WindowGroup {
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
                /*
                
                NavigationView{
                    Allergens()
                        .navigationTitle("Allergènes")
                }
                .tabItem{
                    Image(systemName: "cross.fill")
                    Text("Allergènes")
                }
                
                */
                
                NavigationView{
                    Ingredients()
                        .navigationTitle("Ingrédients")
                }
                .tabItem{
                    Image(systemName: "applelogo")
                    Text("Ingrédients")
                }
                
                /*
                NavigationView{
                    Recipes()
                        .navigationTitle("Recettes")
                }
                .tabItem{
                    Image(systemName: "text.book.closed")
                    Text("Recettes")
                }
                 
                
                
                NavigationView{
                    LabelManagement()
                        .navigationTitle("Etiquettes")
                }
                .tabItem{
                    Image(systemName: "tag.fill")
                    Text("Etiquettes")
                }
                 */
                 
            }
            //LoginView()
            //Badge(backgroundColor: Color.red, fontColor: Color.white, text: "Allergen")
            
        }
    }
}
