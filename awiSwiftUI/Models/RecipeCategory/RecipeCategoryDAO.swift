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
    
    static func postRecipeCategory(recipeCategory : RecipeCategory) async -> RecipeCategory?{
        
        let recipeCatDTO = RecipeCategorytoDTO(recipeCategory: recipeCategory)
        
        guard let url = URL(string: "https://awi-api.herokuapp.com/recipe-category") else {
            print("bad URL")
            return nil
        }
        do{
            var request = URLRequest(url: url)
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            // set (replace) a value to a field
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            guard let encoded = await JSONHelper.encode(data: recipeCatDTO) else {
                print("GoRest: pb encodage")
                return nil
            }

            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                guard let decoded : RecipeCategoryDTO = JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return nil
                }
                print(decoded)
                return RecipeCategoryDAO.DTOtoRecipeCategory(dto: decoded)
                
            }
            else{
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch(let error ){
            
            print("GoRest: bad request \(error)")
        }
        return nil
        
    }
}
