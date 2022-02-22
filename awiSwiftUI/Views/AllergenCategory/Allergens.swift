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
            async let requestAllergens =  AllergenCategoryDAO.getAllergenCategories()
            
            switch(await requestAllergens){
                
            case .success(let resAllergens):
                allergens = resAllergens
            case .failure(let error):
                print(error)
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
