//
//  Allergens.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct Allergens: View{
    
    @State var allergens : [AllergenCategory] = []
    
    @State var searchedAllergenName = ""

    //Barre de recherche
    var searchResult : [AllergenCategory]{
        if(searchedAllergenName.isEmpty){
            return self.allergens
        }
        return self.allergens.filter({$0.name.contains(searchedAllergenName)})
    }
    
    var body: some View{
        VStack(alignment: .trailing){
            List(searchResult){ allergen in
                AllergenRow(allergen: allergen)
            }
            .padding(2)
            .searchable(text: $searchedAllergenName, placement: .navigationBarDrawer(displayMode: .always))
        }
        //Icône de compte
        .toolbar{
            HStack{
                Image(systemName: "person")
            }
        }
        //récupération des allergènes en BD
        .task {
            async let requestAllergens =  AllergenCategoryDAO.getAllergenCategories()
            
            switch(await requestAllergens){
                
            case .success(let resAllergens):
                self.allergens = resAllergens
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}


struct Allergens_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            Allergens(allergens: AllergenCategory.allergens)
        }
        
    }
}
