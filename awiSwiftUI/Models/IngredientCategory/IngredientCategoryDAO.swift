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
    static func getIngredientCategories() async ->Result<[IngredientCategory],Error> {
        
        let getIngredientCategoriesReq : Result<[IngredientCategoryDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "ingredient-category")
        
        switch(getIngredientCategoriesReq){
            
        case .success(let ingredientCatDTOs):
            return .success(IngredientCategoryDAO.DTOsToIngredientCategory(ingredientCategoriesDTO: ingredientCatDTOs))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    static func getIngredientCategory(id : Int) async ->Result<IngredientCategory,Error> {
        
        let getIngredientCategoryReq : Result<IngredientCategoryDTO,Error> = await JSONHelper.httpGet(url: Utils.apiURL + "ingredient-category/" + String(id))
        
        switch(getIngredientCategoryReq){
            
        case .success(let ingredientCatDTO):
            return .success(IngredientCategoryDAO.DTOtoIngredientCategory(dto : ingredientCatDTO))
            
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
