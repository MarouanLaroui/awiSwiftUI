//
//  Allergens.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct Allergens: View{
    
    @State var allergens: [AllergenCategory] = []
    
    var body: some View{
        VStack{
            //TODO: ajouter une barre de recherche
            
            List(allergens){ allergen in
                AllergenRow(allergen: allergen)
            }
            
        }
        //récupération des allergènes en BD
        .task {
            async let requestAllergens : [AllergenCategory]? =  AllergenCategoryDAO.getAllergens()
            
            if let resAllergens = await requestAllergens{
                self.allergens = resAllergens
            }

        }
        
    }
    
    
}


struct Allergens_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            Allergens()
        }
        
    }
}
