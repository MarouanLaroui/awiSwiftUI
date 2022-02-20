//
//  RecipeCategoryDAO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import Foundation

struct RecipeCategoryDAO{
    
    
    static func DTOtoRecipeCategory(dto : RecipeCategoryDTO)->RecipeCategory{
        return RecipeCategory(id: dto.id, name: dto.name)
    }
    
    static func RecipeCategorytoDTO(recipeCategory : RecipeCategory)-> RecipeCategoryDTO{
        return RecipeCategoryDTO(id: recipeCategory.id, name: recipeCategory.name)
    }
    
    static func DTOsToRecipeCategories(dtos : [RecipeCategoryDTO])->[RecipeCategory]{
        var recipeCategories : [RecipeCategory] = []
        dtos.forEach({
            recipeCategories.append(RecipeCategoryDAO.DTOtoRecipeCategory(dto: $0))
        })
        return recipeCategories
    }

    /*HTTP REQUESTS*/
    static func getRecipeCategories() async ->Result<[RecipeCategory],Error> {
        
        let getRecipeCategoriesReq : Result<[RecipeCategoryDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe-category/")
        
        switch(getRecipeCategoriesReq){
            
        case .success(let recipeCatDTOs):
            return .success( RecipeCategoryDAO.DTOsToRecipeCategories(dtos: recipeCatDTOs))
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
