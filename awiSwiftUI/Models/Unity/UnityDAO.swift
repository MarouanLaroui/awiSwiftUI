//
//  UnityDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct UnityDAO{
    
    static func DTOtoUnity(dto : UnityDTO) -> Unity{
        return Unity(id : dto.id, unityName : dto.unityName)
    }
    
    static func DTOsToUnits(dtos : [UnityDTO]) -> [Unity]{
        var units : [Unity] = []
        dtos.forEach(){
            dto in
            units.append(UnityDAO.DTOtoUnity( dto :dto))
        }
        return units
    }
    
    static func UnityToDTO(unity : Unity) -> UnityDTO{
        return UnityDTO(id : unity.id, unityName : unity.unityName)
    }
    
    /*REQUESTS*/
    static func getUnits() async ->Result<[Unity],Error> {
        
        let getUnitsReq : Result<[UnityDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "unity")
        
        switch(getUnitsReq){
            
        case .success(let unitsDTOs):
            return .success(UnityDAO.DTOsToUnits(dtos: unitsDTOs))
            
            
        case .failure(let error):
            return .failure(error)
        }
    }
    static func getUnit(id : Int) async ->Result<Unity,Error> {
        
        let getUnityReq : Result<UnityDTO,Error> = await JSONHelper.httpGet(url: Utils.apiURL + "unity/" + String(id))
        
        switch(getUnityReq){
            
        case .success(let unityDTO):
            return .success(UnityDAO.DTOtoUnity(dto: unityDTO))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
