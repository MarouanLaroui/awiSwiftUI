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
    static func getStepOfRecipe(recipeId : Int) async -> Result<[Step], Error> {
        let getUsersTask : Result<[StepDTO], Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/" + String(recipeId) + "/steps")
        
        switch(getUsersTask){
        case .success(let stepsDTOs):
            return .success(StepDAO.dtosToSteps(stepDTOs: stepsDTOs))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
