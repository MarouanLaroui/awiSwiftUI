//
//  StepToIngredientDAO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 26/02/2022.
//

import Foundation
import UIKit

struct StepToIngredientDAO{
    
    static func deleteStepToIngredientOfStep(stepId : Int)async -> Result<Int,Error> {
        await JSONHelper.httpDelete(url: Utils.apiURL + "ingredient-to-step/" + String(stepId) + "/step")
    }
    
    
    static func createStepToIngredient(ingredientId : Int, stepId : Int, quantity : Int) async -> Result<StepToIngredientDTO,Error>{
        
        let stepToIngredientDTO = StepToIngredientDTO(ingredientId: ingredientId, stepId: stepId, quantity: quantity)
        guard let url = URL(string: "https://awi-api.herokuapp.com/ingredient-to-step")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: stepToIngredientDTO)
            else {
                return .failure(JSONError.JsonEncodingFailed)
            }
                       
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                
                guard let decoded : StepToIngredientDTO = JSONHelper.decode(data: data)
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
            print("failure in StepTOIngredientDAO")
            return .failure(HTTPError.badRequest)
        }
        
    }
    
}
