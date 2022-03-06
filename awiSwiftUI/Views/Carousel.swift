//
//  Carousel.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 14/02/2022.
//

import SwiftUI

struct Carousel: View {
    
    @State private var index = 0
    
    var body: some View {
        VStack{
            TabView(selection: $index) {
            
                HomeCoverSlider(title:"Gestion de stock",caption: "Permet la gestion de ses stocks, vendez et gérer vos stocks en temps réel. Avec vitemarecette plus de pénurie",systemName: "cart")
                    
                HomeCoverSlider(title:"Calcul des coûts",caption: "Vous permet de gérer votre business en calculant les coûts de reviens, les prix de ventes conseillés de vos produits.",systemName: "eurosign.circle")
                    
                HomeCoverSlider(title:"Gestion de stock",caption: "Permet la gestion de ses stocks, vendez et gérer vos stocks en temps réel. Avec vitemarecette plus de pénurie",systemName: "cart")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .padding(.bottom)

    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
