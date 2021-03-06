//
//  Users.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import SwiftUI

struct Users: View {
    
    @ObservedObject var userListVM  = UserListVM(users: [])
    @State var searchedUser : String = ""
    @State var selectedUser : User? = nil
    @State var isSheetShown : Bool = false
    var displayedUsers : [User] {
        if(searchedUser.count > 0){
            return userListVM.users.filter({
                $0.name.contains(searchedUser) || $0.last_name.contains(searchedUser)
            })
        }
        return userListVM.users
    }
    var intent : UserIntent
    
    init(){
        self.intent = UserIntent()
        self.intent.addListObserver(viewModel: userListVM)
    }
    
    var body: some View {
        VStack{
            List(displayedUsers){
                user in
                
                UserRow(userVM: UserVM(model: user))
                    .swipeActions {
                    Button {
                        self.selectedUser = user
                        isSheetShown = true
                    }
                    label: {
                        Image(systemName: "square.and.pencil")
                    }
                        
                    Button {
                        Task{
                            await self.intent.intentToDeleteUser(user: user)
                        }
                    }
                    label: {
                        Image(systemName: "trash")
                    }
                    .background(Color.red)
                        
                    }
                
            }
            .searchable(text: $searchedUser)
            .overlay(
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button("+"){
                            isSheetShown = true
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
            .task {
                
                if(self.userListVM.users.count == 0){
                    
                    let getUserResult = await UserDAO.getUsers()
                    
                    switch(getUserResult){
                        
                    case .success(let users):
                        self.userListVM.users = users
                    case .failure(_):
                        print("failure while retrieving users")
                    }
                    
                }
                
            }
            
            //Formulaire d'ajout/de modification d'utilisateur
            .sheet(isPresented: $isSheetShown, onDismiss: {
                self.selectedUser = nil
            }){
                if let selectedUser = selectedUser {
                    CreateAccountForm(userVM: UserVM(model: selectedUser), isSheetShown: $isSheetShown, intent : self.intent)
                }
                else{
                    CreateAccountForm(isSheetShown: $isSheetShown, intent : self.intent)
                }
            }
        }
    }
    
    struct Users_Previews: PreviewProvider {
        static var previews: some View {
            Users()
        }
    }
}
