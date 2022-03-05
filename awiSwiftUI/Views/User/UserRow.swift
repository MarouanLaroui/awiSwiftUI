//
//  UserRow.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import SwiftUI

struct UserRow: View {
    @ObservedObject var userVM : UserVM
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Image(systemName: "person.crop.circle")

            }
            VStack(alignment: .leading){
                HStack{
                    Text(userVM.name)
                    Text(userVM.last_name)
                    
                }
                Text(userVM.mail)
                    .font(.caption)
            }
            Spacer()
            if(userVM.isAdmin == true){
                Badge(backgroundColor: .green, fontColor: .white, text: "Admin")
            }
        }
        .padding()
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(userVM: UserVM(model: User.users[0]))
    }
}
