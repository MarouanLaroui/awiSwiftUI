//
//  UserAccountView.swift
//  awiSwiftUI
//
//  Created by m1 on 03/03/2022.
//

import Foundation
import SwiftUI

struct UserAccountView: View {
    
    let dateFormatter = DateFormatter()
    
    @EnvironmentObject var loggedUser: User
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var email : String = ""
    @State private var isAdmin : Bool = false
    @State private var birthDate : Date = Date()
    
    var body: some View{
        VStack{
            Form{
                Section("informations"){
                    TextField("prénom",text: $loggedUser.name)
                    TextField("nom",text: $loggedUser.last_name)
                    TextField("phone number", text : $loggedUser.phone)
                    DatePicker("birthdate",selection: $birthDate,displayedComponents: [.date])
                }
                
                Section("credentials"){
                    
                    TextField("email",text: $loggedUser.mail)
                    //NavigationLink(destination : ){
                    Text("Mot de passe")
                    //}
                    
                }
                
                HStack{
                    Spacer()
                    Button("Déconnexion"){
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.loggedUser.access_token = nil
                        }
                        
                    }
                    .foregroundColor(.red)
                    Spacer()
                }
                
                
            }
            
            Spacer()
        }
        .navigationTitle("Mon compte")
        .task {
            /*
            let connectedUser = await UserDAO.getUser(mail: "ophelie@gmail.com")
            print("dans la task connected user")
            
            //Recettes
            switch(connectedUser){
            case .success(let resUser):
                self.connectedUser = resUser
                print("\(resUser.name)")
            case .failure(let error):
                print("error while retrieving connected user" + error.localizedDescription)
            }
             */
        }
    }
}
