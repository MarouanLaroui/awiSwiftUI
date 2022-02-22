//
//  IngredientDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct IngredientDAO{
    
    
    static func IngredientToDTO(ingredient : Ingredient)->IngredientPostDTO{
        
        return IngredientPostDTO(
            //id: ingredient.id,
            name: ingredient.name,
            unitaryPrice: Int(ingredient.unitaryPrice),
            nbInStock: Int(ingredient.nbInStock),
            allergen: ingredient.allergen?.id,
            category: ingredient.category.id!,
            unity:ingredient.unity.id!
        )
    }
    
    static func DTOsToIngredients(dtos : [IngredientGetDTO])->[Ingredient]{
        var ingredients : [Ingredient] = []
        dtos.forEach({
            ingredients.append(IngredientDAO.GetDTOtoIngredient(dto: $0))
        })
        return ingredients
    }
    
    static func GetDTOtoIngredient(dto : IngredientGetDTO)->Ingredient{
        
        guard let allergenDTO = dto.allergen
        else{
            return Ingredient(
                id: dto.id,
                name: dto.name,
                unitaryPrice: dto.unitaryPrice,
                nbInStock: dto.nbInStock,
                ingredientCategory: IngredientCategoryDAO.DTOtoIngredientCategory(dto: dto.category),
                unity: UnityDAO.DTOtoUnity(dto: dto.unity)
            )
        }
        return Ingredient(
            id: dto.id,
            name: dto.name,
            unitaryPrice: dto.unitaryPrice,
            nbInStock: dto.nbInStock,
            allergen : AllergenCategoryDAO.DTOtoAllergenCategory(dto: allergenDTO),
            ingredientCategory: IngredientCategoryDAO.DTOtoIngredientCategory(dto: dto.category),
            unity: UnityDAO.DTOtoUnity(dto: dto.unity)
        )
        
        
    }
    
    
    /*REQUESTS*/
    static func getIngredients()async ->Result<[Ingredient],Error> {
        
        let getIngredientTask : Result<[IngredientGetDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "ingredient")
        
        switch(getIngredientTask){
            
        case .success(let ingredientDTOs):
            return .success(IngredientDAO.DTOsToIngredients(dtos: ingredientDTOs))
            
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getIngredients(id : Int)async ->Result<Ingredient,Error> {
        
        let getIngredientTask : Result<IngredientGetDTO,Error> = await JSONHelper.httpGet(url: Utils.apiURL + "ingredient/" + String(id))
        
        switch(getIngredientTask){
            
        case .success(let ingredientDTO):
            return .success(IngredientDAO.GetDTOtoIngredient(dto: ingredientDTO))
            
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func postIngredientTest() async -> Ingredient?{
        
        print("postIngredientTest")
        let ingredient = Ingredient.ingredients[0]
        let ingredientDTO = IngredientDAO.IngredientToDTO(ingredient: ingredient)
        print(ingredientDTO)
        guard let url = URL(string: "https://awi-api.herokuapp.com/ingredient") else {
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
            guard let encoded = await JSONHelper.encode(data: ingredientDTO) else {
                print("GoRest: pb encodage")
                return nil
            }
            let sencoded = String(data: encoded, encoding: .utf8)!
            print(sencoded)
            let datatest = "{\"unity\":2,\"unitaryPrice\":10,\"allergen\":10,\"name\":\"MARCHEPTN\",\"nbInStock\":3,\"category\":2}".data(using: .utf8)!
            let sencoded2 = String(data: datatest, encoding: .utf8)!
            print(sencoded2)
            let (data, response) = try await URLSession.shared.upload(for: request, from: datatest)
            
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                print("GoRest Result: \(sdata)")
                guard let decoded : IngredientGetDTO = await JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise récupération de données")
                    return nil
                }
                print("---------successs----------------")
                print(decoded)
                return IngredientDAO.GetDTOtoIngredient(dto: decoded)
                //self.users.append(decoded.data)
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
    
    /*
     let ingredient = Ingredient.ingredients[0]
     let ingredientDTO = IngredientDAO.IngredientToDTO(ingredient: ingredient)
     print("ingredientDTO : ")
     print(ingredientDTO)
     let encodedData = await JSONHelper.encode(data: ingredientDTO)
     let url = URL(string: Utils.apiURL + "ingredient")!
     let request = URLRequest(url: url)
     
     guard let data = encodedData
     else{return nil}
     do{
     let (received_data, response) = try await URLSession.shared.upload(for: request, from: data)
     let httpresponse = response as! HTTPURLResponse
     
     if(httpresponse.statusCode == 201){
     guard let decoded : IngredientGetDTO = JSONHelper.decode(data: received_data)
     else{return nil}
     }
     else{
     print("Error \(httpresponse.statusCode)")
     }
     }
     catch(let err){
     
     print("catch err")
     print(err)
     print(err.localizedDescription)
     }
     return nil
     */
    
    static func postIngredient(ingredient : Ingredient) async -> Ingredient?{
        
        let ingredientDTO = IngredientDAO.IngredientToDTO(ingredient: ingredient)
        let encodedData = await JSONHelper.encode(data: ingredientDTO)
        guard let url = URL(string: "https://awi-api.herokuapp.com/ingredient")
        else{fatalError()}
        
        let request = URLRequest(url: url)
        
        guard let data = encodedData
        else{return nil}
        do{
            let (received_data, response) = try await URLSession.shared.upload(for: request, from: data)
            let httpresponse = response as! HTTPURLResponse
            
            if(httpresponse.statusCode == 201){
                guard let decoded : IngredientGetDTO = JSONHelper.decode(data: received_data)
                else{return nil}
            }
            else{
                print("Error \(httpresponse.statusCode)")
            }
        }
        catch(let err){
            print(err.localizedDescription)
        }
        return nil
    }
}
