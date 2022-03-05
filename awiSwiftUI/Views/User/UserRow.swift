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
        HStack{
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .foregroundColor(.salmon)
                .opacity(0.8)

            
            VStack(alignment: .leading){
                HStack{
                    Text(userVM.name)
                    Text(userVM.last_name)
                    
                }
                
                Text(userVM.birthdate, style: .date)
                    .font(.caption)
                    .italic()
                Text(userVM.mail)
                    .font(.caption)
            }
            Spacer()
            if(userVM.isAdmin == true){
                Badge(backgroundColor: .teal, fontColor: .white, text: "Admin")
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
