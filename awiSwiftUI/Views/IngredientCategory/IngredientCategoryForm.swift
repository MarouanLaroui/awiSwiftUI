//
//  IngredientCategoryForm.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 08/02/2022.
//

import SwiftUI

struct IngredientCategoryForm: View {
    @StateObject var ingredientCategoryFormViewModel = IngredientCategoryFormViewModel(model : IngredientCategory(category_name : ""))
    var body: some View {
        Form{
            TextField("Category name",text :$ingredientCategoryFormViewModel.category_name)
        }
        .navigationTitle("New ingredient category")
    }
}

struct IngredientCategoryForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            IngredientCategoryForm()
        }
    }
}
