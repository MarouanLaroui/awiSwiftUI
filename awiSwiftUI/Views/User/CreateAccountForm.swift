//
//  CreateAccountForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 06/02/2022.
//

import SwiftUI

struct CreateAccountForm: View {
    
    @ObservedObject var userVM : UserVM
    var intent = UserIntent()
    @State private var birthDate : Date = Date()
    @Binding var isSheetShown : Bool
    
    init(userVM : UserVM? = nil, isSheetShown : Binding<Bool>){
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
            
            Form{

                Section("informations"){
                    TextField("firstname",text: $userVM.name)
                        .onSubmit {
                            print("OnSubmit firstname")
                            self.intent.intentToChange(name: self.userVM.name)
                        }
                    TextField("lastname",text: $userVM.last_name)
                        .onSubmit {
                            self.intent.intentToChange(last_name: self.userVM.last_name)
                        }
                    TextField("phone number", text : $userVM.phone)
                        .onSubmit {
                            self.intent.intentToChange(phone: self.userVM.phone)
                        }
                    DatePicker("birthdate",selection: $userVM.birthdate,displayedComponents: [.date])
                        .onSubmit {
                            self.intent.intentToChange(birthdate: Date.toString(date: self.userVM.birthdate))
                        }
                    
                }
                
                Section("credentials"){
                    Toggle("is Admin",isOn: $userVM.isAdmin)
                        .onSubmit {
                            self.intent.intentToChange(isAdmin: self.userVM.isAdmin)
                        }
                    TextField("email adress",text: $userVM.mail)
                        .onSubmit {
                            self.intent.intentToChange(mail: self.userVM.mail)
                        }
                    
                }
                HStack{
                    Spacer()
                    Button("Create"){
                        Task{
                            await self.intent.intentToPostUser(user: self.userVM.model)
                            self.isSheetShown = false
                        }
                        
                    }
                    Spacer()
                }
                
            }
            
        }
        .navigationTitle("Create account")
        
        
        
    }
}
/*
struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CreateAccountForm(userVM: UserVM(model: User.users[0]),isSheetShown: &true)
        }
    }
}

*/
