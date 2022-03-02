//
//  RecipeDAO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import Foundation

struct RecipeDAO{
    
    
    static func RecipeToDTO(recipe : Recipe)->RecipeDTO{
        
        return RecipeDTO(
            id: recipe.id,
            title: recipe.title,
            nbOfServing: recipe.nbOfServing,
            personInCharge: recipe.personInCharge,
            specificEquipment: recipe.specificEquipment,
            dressingEquipment: recipe.dressingEquipment,
            recipeCategory: RecipeCategoryDAO.RecipeCategorytoDTO(recipeCategory: recipe.recipeCategory),
            author: UserDAO.userToDTO(user: recipe.author)
        )
    }

    
    static func DTOtoRecipe(dto : RecipeDTO)->Recipe{
        return Recipe(
            id: dto.id,
            title: dto.title,
            nbOfServing: dto.nbOfServing,
            personInCharge: dto.personInCharge,
            specificEquipment: dto.specificEquipment,
            dressingEquipment: dto.dressingEquipment,
            recipeCategory: RecipeCategoryDAO.DTOtoRecipeCategory(dto: dto.recipeCategory),
            author: UserDAO.dtoToUser(dto: dto.author)
        )
    }
    
    static func DTOsToRecipes(dtos : [RecipeDTO])->[Recipe]{
        var recipes : [Recipe] = []
        dtos.forEach({
            recipes.append(RecipeDAO.DTOtoRecipe(dto: $0))
        })
        return recipes
    }
    
    /*REQUESTS*/
    static func getRecipes() async ->Result<[Recipe],Error> {
        
        let getRecipeQuery : Result<[RecipeDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe")
        
        switch(getRecipeQuery){
            
        case .success(let recipeDTOs):
            print("success in getRecipes RecipeDAO")
            return .success(RecipeDAO.DTOsToRecipes(dtos: recipeDTOs))
            
            
        case .failure(let error):
            print("failure in getRecipes RecipeDAO")
            return .failure(error)
        }
    }
    
    static func getRecipe(id : Int)async ->Result<Recipe,Error> {
        
        let getRecipeQuery : Result<RecipeDTO,Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/" + String(id))
        
        switch(getRecipeQuery){
            
        case .success(let recipeDTO):
            return .success(RecipeDAO.DTOtoRecipe(dto: recipeDTO))
            
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getRecipeDuration(id : Int) async -> Result<Int, Error>{
        let getRecipeDurationReq : Result<Int, Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/"+String(id)+"/time")
        
        switch(getRecipeDurationReq){
        case .success(let recipeDuration):
            return .success(recipeDuration)
        case .failure(let error):
            return .failure(error)
        
        }
    }
    
    static func getRecipeCost(id : Int) async -> Result<Int, Error>{
        let getRecipeDurationReq : Result<Int, Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/"+String(id)+"/cost")
        
        switch(getRecipeDurationReq){
        case .success(let recipeDuration):
            return .success(recipeDuration)
        case .failure(let error):
            return .failure(error)
        
        }
    }
    
    
    
    //TODO: fonction de post d'une recette 
}
