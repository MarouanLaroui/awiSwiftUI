//
//  ContentView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email : String = "";
    @State private var password : String = "";
    
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
            
                TextField("email",text :$email)
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
                    
                }
                .padding(10)
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
            /*
            Form{
                TextField("email",text :$email)
                TextField("password",text :$password)
            }
            .navigationTitle("LOGIN")
            HStack{
                Button("LOGIN"){}
            }
             */
        }
        

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView()
        }
        
    }
}
