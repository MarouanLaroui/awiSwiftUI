//
//  RecipeIsComposedOfGeneralStepDAO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import Foundation

struct RecipeIsComposedOfGeneralStepDAO{
    static func postRecipeIsComposedOfGeneralStep(recipeId : Int, generalStepId : Int, stepNbOfOrder : Int) async -> Result<RecipeIsComposedOfGeneralStepDTO,Error>{
        
        let recipeIsComposedOfGeneralStepDTO = RecipeIsComposedOfGeneralStepDTO(recipeId: recipeId, generalStepId: generalStepId, stepNbOfOrder: stepNbOfOrder)
        guard let url = URL(string: "https://awi-api.herokuapp.com/recipe-iscomposed-of-generalsteps")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: recipeIsComposedOfGeneralStepDTO) else {
                return .failure(JSONError.JsonEncodingFailed)
            }
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                
                guard let decoded : RecipeIsComposedOfGeneralStepDTO = JSONHelper.decode(data: data)
                else {
                    return .failure(HTTPError.badRecoveryOfData)
                    
                }
                return .success(decoded)
            }
            else{
                print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                return .failure(HTTPError.badURL)
            }
        }
        catch(_){
            return .failure(HTTPError.badRequest)
        }
    }
}
