//
//  StepDAO.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 24/02/2022.
//

import Foundation

struct StepDAO{
    
    static func stepToDTO(step : Step)->StepDTO{
        return StepDTO(
            id: step.id,
            title: step.title,
            description: step.description,
            time: step.time
        )
    }
    
    static func dtoToStep(stepDTO : StepDTO)->Step{
        return Step(
            id: stepDTO.id,
            title: stepDTO.title,
            description: stepDTO.description,
            time: stepDTO.time,
            ingredients : [:]
        )
    }
        
    static func dtosToSteps(stepDTOs : [StepDTO])->[Step]{
        var steps : [Step] = []
        stepDTOs.forEach({steps.append(StepDAO.dtoToStep(stepDTO: $0))})
        return steps
    }
    
    /*REQUESTS*/
    
    static func getStepIngredients(stepId : Int)async -> Result<[Ingredient:Int],Error>{
        let getIngredientTask : Result<[IngredientGetDTO], Error> = await JSONHelper.httpGet(url: Utils.apiURL + "step/" + String(stepId) + "/ingredient" )
        switch(getIngredientTask){
            
        case .success(let dtos):
            return .success(IngredientDAO.getDTOtoDict(dtos: dtos))
        case .failure(let error):
            return .failure(error)
        }
    }
    static func getStepOfRecipe(recipeId : Int) async -> Result<[Step], Error> {
        
        let getUsersTask : Result<[StepDTO], Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/" + String(recipeId) + "/steps")
        
        switch(getUsersTask){
        case .success(let stepsDTOs):
            return .success(StepDAO.dtosToSteps(stepDTOs: stepsDTOs))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getStepOfRecipeDetailled(recipeId : Int) async -> Result<[Step], Error> {
        let getUsersTask : Result<[StepDTO], Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/" + String(recipeId) + "/steps")
        
        switch(getUsersTask){
        case .success(let stepsDTOs):
            let steps  = StepDAO.dtosToSteps(stepDTOs: stepsDTOs)
            for step in steps {
                let result = await StepDAO.getStepIngredients(stepId: step.id!)
                
                switch(result){
                    
                case .success(let ingredients):
                    step.ingredients = ingredients
                case .failure(let error):
                    return .failure(error)
                }
            }
            return .success(steps)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    static func updateStepOfRecipe(recipeId : Int, step : Step, stepNbOfOrder : Int) async -> Result<Step,Error>{

        let stepDTO = StepDAO.stepToDTO(step: step)
        guard let url = URL(string: "https://awi-api.herokuapp.com/step")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: stepDTO) else {
                return .failure(JSONError.JsonEncodingFailed)
            }
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                
                guard let decoded : StepDTO = JSONHelper.decode(data: data)
                else {
                    return .failure(HTTPError.badRecoveryOfData)
                }
                
                /*IngredientToStep*/
                for (ingredient, quantity) in step.ingredients {
                    await StepToIngredientDAO.createStepToIngredient(ingredientId: ingredient.id!, stepId: decoded.id!, quantity: quantity)
                }
                return .success(step)
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
    
    static func createStepOfRecipe(recipeId : Int, step : Step, stepNbOfOrder : Int) async -> Result<Step,Error>{
        
        let stepDTO = StepDAO.stepToDTO(step: step)
        guard let url = URL(string: "https://awi-api.herokuapp.com/step")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: stepDTO) else {
                return .failure(JSONError.JsonEncodingFailed)
            }
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                guard let decoded : StepDTO = JSONHelper.decode(data: data)
                else {
                    return .failure(HTTPError.badRecoveryOfData)
                }
                
                /*StepIsComposeOfGeneralSteps*/
                let result = await RecipeIsComposedOfGeneralStepDAO.postRecipeIsComposedOfGeneralStep(recipeId: recipeId, generalStepId: decoded.id!, stepNbOfOrder: stepNbOfOrder)
                
                switch(result){
                    
                case .success(_):
                    /*Ingredient To Step */
                    for (ingredient, quantity) in step.ingredients {
                        print(quantity)
                        await StepToIngredientDAO.createStepToIngredient(ingredientId: ingredient.id!, stepId: decoded.id!, quantity: quantity)
                    }
                    return .success(step)
                    
                case .failure(let error):
                    return .failure(error)
                }
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
    
    static func deleteStep(stepId : Int) async ->Result<Int,Error>{
        return await JSONHelper.httpDelete(url: Utils.apiURL + "step/" + String(stepId))
    }
    
    static func deleteIngredientFromStep(stepId : Int, ingredientId : Int) async -> Result<Int,Error>{
        return await JSONHelper.httpDelete(url: Utils.apiURL + "ingredient-to-step/step/" + String(stepId) + "/ingredient/" + String(ingredientId))
    }

}
