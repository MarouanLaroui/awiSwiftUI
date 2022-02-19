//
//  HomeCoverSlider.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 13/02/2022.
//

import SwiftUI

struct HomeCoverSlider: View {
    
    var title : String
    var caption : String
    var systemName : String
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                    
            }
            .padding(.bottom,10)
            Text(caption)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .padding()
            Image(systemName: systemName)
                .foregroundColor(.white)
            
        
        }
        .padding(.top,75)
        .padding(.bottom,75)
        .background(Color.salmon)
        .cornerRadius(10)
        
        
    }
}

struct HomeCoverSlider_Previews: PreviewProvider {
    static var previews: some View {
        HomeCoverSlider(title: "", caption: "",systemName:"cart")
    }
}
