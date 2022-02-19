//
//  IngredientCategoryDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation


struct IngredientCategoryDAO{

    static func DTOtoIngredientCategory(dto : IngredientCategoryDTO)->IngredientCategory{
        return IngredientCategory(id: dto.id, category_name: dto.category_name)
    }
    
    static func IngredientCategoryToDTO(ingredientCategory : IngredientCategory)->IngredientCategoryDTO{
        return IngredientCategoryDTO(id: ingredientCategory.id, category_name: ingredientCategory.category_name)
    }
    
                                
    static func ingredientCategoryToDTOs(ingredientCategories : [IngredientCategory])->[IngredientCategoryDTO]{
        var ingredientCategoriesDTO : [IngredientCategoryDTO] = []
        ingredientCategories.forEach({
            ingredientCategoriesDTO.append(IngredientCategoryDAO.IngredientCategoryToDTO(ingredientCategory: $0))
        })
        return ingredientCategoriesDTO
    }
    
    static func DTOsToIngredientCategory(ingredientCategoriesDTO : [IngredientCategoryDTO])->[IngredientCategory]{
        var ingredientCategories : [IngredientCategory] = []
        ingredientCategoriesDTO.forEach({
            ingredientCategories.append(IngredientCategoryDAO.DTOtoIngredientCategory(dto: $0))
        })
        return ingredientCategories
    }
         
    /*REQUESTS*/
    static func getIngredientCategories()async ->[IngredientCategory]? {
        if let url = URL(string: Utils.apiURL + "ingredient-category") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : [IngredientCategoryDTO] = JSONHelper.decodeList(data: data) {
                    return IngredientCategoryDAO.DTOsToIngredientCategory(ingredientCategoriesDTO: dtos)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
    static func getIngredientCategory(id : Int)async -> IngredientCategory? {
        if let url = URL(string: Utils.apiURL + "ingredient-category/:" + String(id)) {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dto : IngredientCategoryDTO = JSONHelper.decode(data: data) {
                    return IngredientCategoryDAO.DTOtoIngredientCategory(dto: dto)                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
}
