//
//  ContentView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @State private var mail : String = "";
    @State private var password : String = "";
    @State private var loginFailedMessage : String?
    @EnvironmentObject var loggedUser: User
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Vite Ma Recette")
                    .font(.title)
                    .bold()
                Text("(très vite)")
                    .font(.footnote)
                Image("saute")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(.bottom,30)
            
                Group{
                    TextField("email",text :$mail)
                        .padding()
                        .cornerRadius(5.0)
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.salmon, lineWidth: 1)
                            )
                    
                }
                .padding([.horizontal], 20)
                

                
                
                SecureField("password",text :$password)
                    .padding()
                    .cornerRadius(5.0)
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.salmon, lineWidth: 1)
                        )
                    .padding([.horizontal, .bottom], 20)
                Text("Mot de passe oublié ?")
                    .font(.caption2)
                    .padding(.bottom,10)
                
                Button("Se connecter"){

                    Task{
                        let result = await UserDAO.login(mail: self.mail, password: self.password)
                        
                        switch(result){
                            
                        case .success(let user):
                            
                            self.loggedUser.id = user.id
                            self.loggedUser.name = user.name
                            self.loggedUser.last_name = user.last_name
                            self.loggedUser.mail =  user.mail
                            self.loggedUser.phone = user.phone
                            self.loggedUser.isAdmin = user.isAdmin
                            self.loggedUser.birthdate = user.birthdate
                            self.loggedUser.access_token = true
                      
                        case .failure(let error):
                            switch(error){
                            case HTTPError.unauthorized :
                                self.loginFailedMessage = "Mauvais identifiants de connexion"
                            default :
                                self.loginFailedMessage = "Erreur de connection" + error.localizedDescription
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Text(loginFailedMessage ?? "")
                    .foregroundColor(.red)
                Spacer()
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            
        }
        
    }
}
