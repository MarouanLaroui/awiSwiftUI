//
//  Badge.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import SwiftUI

struct Badge: View {
    
    var backgroundColor : Color
    var fontColor : Color
    var text : String
    
    var body: some View {
        
        Text(text)
            .padding(6)
            .background(backgroundColor)
            .foregroundColor(fontColor)
            .cornerRadius(10)
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(backgroundColor: Color.red, fontColor: Color.white, text: "Allergen")
    }
}
