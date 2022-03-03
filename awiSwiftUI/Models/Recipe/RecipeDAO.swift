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
    
    static func createRecipe(recipe : Recipe) async -> Result<Recipe,Error>{
        
        let recipeDTO = RecipeDAO.RecipeToDTO(recipe: recipe)
        guard let url = URL(string: "https://awi-api.herokuapp.com/recipe")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
    
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: recipeDTO)
            else {return .failure(JSONError.JsonEncodingFailed)}
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                
                guard let decoded : RecipeDTO = JSONHelper.decode(data: data)
                else {return .failure(HTTPError.badRecoveryOfData)}
            
                let retrievedRecipe =  RecipeDAO.DTOtoRecipe(dto: decoded)
                return .success(retrievedRecipe)
                
            }
            else{
                //ERROR TO CHANGE
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                return .failure(HTTPError.badURL)
            }
        }
        catch(_){
            return .failure(HTTPError.badRequest)
        }
    }
    //TODO: fonction de post d'une recette 
}
