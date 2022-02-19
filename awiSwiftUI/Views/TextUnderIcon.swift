//
//  TextUnderIconView.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 09/02/2022.
//

import SwiftUI

struct TextUnderIconView: View {
    
    var systemImageStr : String
    var text : String
    
    var body: some View {
        VStack{
            Label("",systemImage:systemImageStr)
            Text(text)
                .font(.caption)
            
        }
    }
}

struct TextUnderIconView_Previews: PreviewProvider {
    static var previews: some View {
        TextUnderIconView(systemImageStr: "timer",text: "10 mn")
    }
}
