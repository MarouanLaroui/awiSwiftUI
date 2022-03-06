//
//  CreateAccountForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI

struct CreateAccountForm: View {
    
    @ObservedObject var userVM : UserVM
    var intent : UserIntent
    @State private var birthDate : Date = Date()
    @Binding var isSheetShown : Bool
    
    init(userVM : UserVM? = nil, isSheetShown : Binding<Bool>, intent : UserIntent){
        self.intent = intent
        if let userVM = userVM {
            self.userVM = userVM
        }
        else{
            self.userVM = UserVM(model: User(name: "", last_name: "", mail: "", phone: "", isAdmin: false, birthdate: ""))
        }
        self._isSheetShown = isSheetShown
        self.intent.addObserver(viewModel: self.userVM)
    }
    
    var body: some View {
        
        VStack{
            
            VStack(alignment: .leading){
                if(userVM.name == ""){
                    Text("Ajouter un utilisateur")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                }
                else {
                    Text("Modifier un compte")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                }
                
                Group{
                    TextField("Prénom",text: $userVM.name)
                        .onSubmit {
                            print("OnSubmit firstname")
                            self.intent.intentToChange(name: self.userVM.name)
                        }
                        .underlineTextField(color: .gray)
                    
                    Text(self.userVM.nameErrorMsg)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Group{
                    TextField("Nom",text: $userVM.last_name)
                        .onSubmit {
                            self.intent.intentToChange(last_name: self.userVM.last_name)
                        }
                        .underlineTextField(color: .gray)
                    
                    HStack{
                        Text(self.userVM.last_nameErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
                
                Group{
                    HStack{
                        Image(systemName: "phone.fill")
                        TextField("Téléphone", text : $userVM.phone)
                            .onSubmit {
                                self.intent.intentToChange(phone: self.userVM.phone)
                            }
                            .underlineTextField(color: .gray)
                    }
                    
                    HStack{
                        Text(self.userVM.phoneErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
                Group{
                    HStack{
                        Image(systemName: "at")
                        TextField("Adresse mail",text: $userVM.mail)
                            .onSubmit {
                                self.intent.intentToChange(mail: self.userVM.mail)
                            }
                            .underlineTextField(color: .gray)
                    }
                    
                    HStack{
                        Text(self.userVM.mailErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
                Group{
                    HStack{
                        Image(systemName: "calendar")
                        DatePicker("Date de naissance",selection: $userVM.birthdate,displayedComponents: [.date])
                            .onSubmit {
                                self.intent.intentToChange(birthdate: Date.toString(date: self.userVM.birthdate))
                            }
                    }
                    
                    HStack{
                        Text(self.userVM.birthdateErrorMsg)
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
                Group{
                    Toggle("Cet utilisateur est admin ?",isOn: $userVM.isAdmin)
                        .onSubmit {
                            self.intent.intentToChange(isAdmin: self.userVM.isAdmin)
                        }                    
                }
                Spacer()
            }
            .padding(30)
            Spacer()
            
            VStack{
                Group{
                    
                    HStack{
                        Button("Annuler"){
                            self.isSheetShown = false
                        }
                        .padding(10)
                        .foregroundColor(.salmon)
                        .cornerRadius(10)
                        Button("Enregistrer"){
                            if(self.userVM.isValid){
                                Task{
                                    await self.intent.intentToPostUser(user: self.userVM.model)
                                    self.isSheetShown = false
                                }
                            }
                            else{
                                self.userVM.reloadErrorMsg()
                            }
                        }
                        .padding(10)
                        .background(Color.salmon)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    .padding(.bottom, 20)
                }
            }
            
        }
        
    }
}
