//
//  CreateAccountForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI

struct CreateAccountForm: View {
    
    
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var email : String = ""
    @State private var phone : String = ""
    @State private var isAdmin : Bool = false
    @State private var birthDate : Date = Date()
    
    var body: some View {
        VStack{
            
            Form{

                Section("informations"){
                    TextField("firstname",text: $firstName)
                    TextField("lastname",text: $lastName)
                    TextField("phone number", text : $phone)
                    DatePicker("birthdate",selection: $birthDate,displayedComponents: [.date])
                    
                }
                
                Section("credentials"){
                    Toggle("is Admin",isOn: $isAdmin)
                    TextField("email",text: $email)
                    
                }
                
            }
            
        }
        .navigationTitle("Create account")
        
        
        
    }

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CreateAccountForm()
        }
    }
}
}
