//
//  UserDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct UserDAO{
    
    static func dtoToUser(dto : UserDTO)->User{
        return User(id: dto.id, name: dto.name, last_name: dto.last_name, mail: dto.mail, phone: dto.phone, isAdmin: dto.isAdmin, birthdate: dto.birthdate)
    }
    
    static func userToDTO(user : User)->UserDTO{
        return UserDTO(id: user.id, name: user.name, last_name: user.last_name, mail: user.mail, phone: user.phone, birthdate: user.birthdate, isAdmin: user.isAdmin)
    }
    /*
    static func connect(user : User) async -> U?{
        
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
            
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                print("GoRest Result: \(sdata)")
                guard let decoded : RecipeCategoryDTO = await JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return nil
                }
                print("---------successs----------------")
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
    */
}
