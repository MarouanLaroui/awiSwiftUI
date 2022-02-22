//
//  AllergenCategoryListViewModel.swift
//  awiSwiftUI
//
//  Created by m1 on 21/02/2022.
//

import Foundation
import Combine

class AllergenCategoryListViewModel {
        
    @Published var allergens : [AllergenCategory]
    
    init(allergens : [AllergenCategory]){
        self.allergens = allergens
    }
    
}
