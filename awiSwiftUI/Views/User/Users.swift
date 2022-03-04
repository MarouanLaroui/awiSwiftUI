//
//  Users.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import SwiftUI

struct Users: View {
    
    @ObservedObject var userListVM  = UserListVM(users: [])
    var body: some View {
        VStack{
            List(userListVM.users){
                user in
                
                UserRow(user: user)
                    .swipeActions {
                        NavigationLink(destination : CreateAccountForm(userVM: UserVM(model: user))){
                            Image(systemName: "square.and.pencil")
                        }
                        
                        Button {
                            Task{
                                
                            }
                        }
                    label: {
                        Image(systemName: "trash")
                    }
                    .background(Color.red)
                        
                    }
                
            }
            .overlay(
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink(destination :
                                        CreateAccountForm()
                        ){
                            Text("+")
                                .frame(width: 25, height: 25)
                                .font(.title)
                                .padding()
                                .background(Color.salmon)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        
                    }
                }
                    .padding()
            )
            .task {
                let getUserResult = await UserDAO.getUsers()
                
                switch(getUserResult){
                    
                case .success(let users):
                    self.userListVM.users = users
                case .failure(_):
                    print("failure while retrieving users")
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
