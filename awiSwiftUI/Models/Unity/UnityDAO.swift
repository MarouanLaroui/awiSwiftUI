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
    static func getUnits()async ->[Unity]? {
        if let url = URL(string: Utils.apiURL + "unity") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : [UnityDTO] = JSONHelper.decodeList(data: data) {
                    return UnityDAO.DTOsToUnits(dtos: dtos)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
    static func getUnity()async ->Unity? {
        if let url = URL(string: Utils.apiURL + "unity") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dto : UnityDTO = JSONHelper.decode(data: data) {
                    return UnityDAO.DTOtoUnity(dto: dto)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
}
