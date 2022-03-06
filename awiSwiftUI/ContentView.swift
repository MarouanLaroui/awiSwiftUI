//
//  ContentView.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 19/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loggedInUser : User = User(name: "", last_name: "", mail: "", phone: "", isAdmin: false, birthdate: "",access_token : true)
    
    
    var body: some View {
        LoggedInView()
        /*if(loggedInUser.access_token == nil){
            LoginView()
                .environmentObject(loggedInUser)
        }
        else{
            LoggedInView()
                .environmentObject(loggedInUser)
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
