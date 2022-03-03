//
//  UserAccountView.swift
//  awiSwiftUI
//
//  Created by m1 on 03/03/2022.
//

import Foundation
import SwiftUI

struct UserAccountView: View {
    
    @State var isFormDisplayed = false
    let dateFormatter = DateFormatter()
    
    @State var connectedUser : User  = User(id: 1, name: "", last_name: "", mail: "", phone: "", isAdmin: true, birthdate: "")
    
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var email : String = ""
    @State private var isAdmin : Bool = false
    @State private var birthDate : Date = Date()

    var body: some View{
        VStack{
            Form{
                Section("informations"){
                    TextField("prénom",text: $connectedUser.name)
                    TextField("nom",text: $connectedUser.last_name)
                    /*
                    DatePicker(selection: $connectedUser.birthdate, in: ...Date(),displayedComponents: .date) {
                                Text("birthdate:")
                            }
                            .onChange(of: connectedUser.birthdate) { (date) in
                                connectedUser.birthdate = DateFormatter.date.string(from: date)
                            }
                     */
                }
                
                Section("credentials"){
                    Toggle("Admin ?",isOn: $connectedUser.isAdmin)
                    TextField("email",text: $connectedUser.mail)
                    
                }
                
            }
            
            Spacer()
        }
        .navigationTitle("Mon compte")
        .task {
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
        }
        
        //Create new account
        .overlay(
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button("+"){
                        isFormDisplayed.toggle()
                        print("click button \(isFormDisplayed)")
                    }
                    .frame(width: 25, height: 25)
                    .font(.title)
                    .padding()
                    .background(Color.salmon)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                }
            }
                .padding()
                
        )
        
        .sheet(isPresented: $isFormDisplayed){
            CreateAccountForm()
        }
    }
}