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
    
    
    static func postUnity(unity : Unity) async -> Unity?{
        
        let unityDTO = UnityToDTO(unity: unity)
        
        guard let url = URL(string: "https://awi-api.herokuapp.com/unity") else {
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
            guard let encoded = await JSONHelper.encode(data: unityDTO) else {
                print("GoRest: pb encodage")
                return nil
            }

            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                print("GoRest Result: \(sdata)")
                guard let decoded : UnityDTO = JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return nil
                }
                print("---------successs----------------")
                print(decoded)
                return UnityDAO.DTOtoUnity(dto: decoded)
                
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
