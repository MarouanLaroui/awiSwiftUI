//
//  UserRow.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 04/03/2022.
//

import SwiftUI

struct UserRow: View {
    @State var user : User = User.users[0]
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Image(systemName: "person.circle.fill")

            }
            VStack(alignment: .leading){
                HStack{
                    Text(user.name)
                    Text(user.last_name)
                    
                }
                Text(user.mail)
                    .font(.caption)
            }
            Spacer()
            Badge(backgroundColor: .red, fontColor: .white, text: "Admin")
        }
        .padding()
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow()
    }
}
