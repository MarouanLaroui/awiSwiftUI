//
//  ContentView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var mail : String = "";
    @State private var password : String = "";
    @State private var loginFailedMessage : String?
    //@State private var error : Error?
    @Binding var isLoggedIn : Bool
    
    func login(){
        
    }
    
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
            
                TextField("email",text :$mail)
                    .padding()
                    .cornerRadius(5.0)
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.salmon, lineWidth: 1)
                        )
                    .padding([.horizontal, .bottom], 20)
    
                
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
                            //Store user 
                            self.isLoggedIn = true
                            
                        case .failure(let error):
                            self.loginFailedMessage = "Erreur de connection" + error.localizedDescription
                        
                        }
                    }
                }
                .padding(10)
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
        }
        /*
        .alert(item: $error){ error in
            let message = "Erreur de connexion :"
            switch(error){
            case .HTTPError.unauthorized :
                message = message + " Identifiants invalides"
            }
            Alert(
                title: Text(item),
                dismissButton: .cancel()
            )
        }
         */
        

    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            
        }
        
    }
}
