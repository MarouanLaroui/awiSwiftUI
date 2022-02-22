//
//  Allergens.swift
//  awiSwiftUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation
import SwiftUI

struct Allergens: View{
    
    @ObservedObject var allergenVM : AllergenCategoryListViewModel = AllergenCategoryListViewModel(allergens: [])
    @State var searchedAllergenName = ""

    //Barre de recherche
    var searchResult : [AllergenCategory]{
        if(searchedAllergenName.isEmpty){
            return allergenVM.allergens
        }
        return allergenVM.allergens.filter({$0.name.contains(searchedAllergenName)})
    }
    
    var body: some View{
        VStack{
            List(searchResult){ allergen in
                AllergenRow(allergen: allergen)
            }
            .searchable(text: $searchedAllergenName, placement: .navigationBarDrawer(displayMode: .always))
        }
        //récupération des allergènes en BD
        .task {
            async let requestAllergens =  AllergenCategoryDAO.getAllergenCategories()
            
            switch(await requestAllergens){
                
            case .success(let resAllergens):
                allergenVM.allergens = resAllergens
            case .failure(let error):
                print(error)
            }
            
        }
        //Icône de compte
        .toolbar{
            HStack{
                Image(systemName: "person")
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
