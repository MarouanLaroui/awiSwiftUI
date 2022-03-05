//
//  ViewExtension.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 05/03/2022.
//

import Foundation
import SwiftUI

extension View {
    func underlineTextField(color : Color) -> some View {
        self
            .padding(.vertical, 5)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(color)
    
    }
}
