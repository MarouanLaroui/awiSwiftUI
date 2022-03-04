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
            }
        }
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
