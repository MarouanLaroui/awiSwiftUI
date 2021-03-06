//
//  AllergenCategoryDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct AllergenCategoryDAO{
    
    
    static func DTOtoAllergenCategory(dto : AllergenCategoryDTO) -> AllergenCategory{
        return AllergenCategory(id : dto.id, name : dto.name)
    }
    
    static func DTOsToAllergenCategories(dtos : [AllergenCategoryDTO]) -> [AllergenCategory]{
        var allergenCategories : [AllergenCategory] = []
        dtos.forEach(){
            dto in
            allergenCategories.append(AllergenCategoryDAO.DTOtoAllergenCategory( dto :dto))
        }
        return allergenCategories
    }
    
    
    
    static func AllergenCategorytoDTO(allergenCategory : AllergenCategory) -> AllergenCategoryDTO{
        return AllergenCategoryDTO(id : allergenCategory.id, name : allergenCategory.name)
    }
    
    static func AllergenCategoriesToDTOs(allergenCategories : [AllergenCategory]) -> [AllergenCategoryDTO]{
        var allergenCategoriesDTO : [AllergenCategoryDTO] = []
        allergenCategories.forEach(){
            allergenCategory in
            allergenCategoriesDTO.append(AllergenCategoryDAO.AllergenCategorytoDTO(allergenCategory: allergenCategory))
        }
        return allergenCategoriesDTO
    }
    
    /*HTTP QUERIES*/
    
    /*REQUESTS*/
    static func getAllergenCategories() async ->Result<[AllergenCategory],Error> {
        
        let getAllergenCategoriesDTOReq : Result<[AllergenCategoryDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "allergen-category")
        
        switch(getAllergenCategoriesDTOReq){
            
        case .success(let allergenCatDTO):
            return .success(AllergenCategoryDAO.DTOsToAllergenCategories(dtos: allergenCatDTO))
            
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    
    static func getAllergenCategory(id : Int) async ->Result<AllergenCategory,Error> {
        
        let getAllergenCatReq : Result<AllergenCategoryDTO,Error> = await JSONHelper.httpGet(url: Utils.apiURL + "allergen-category/" + String(id))
        
        switch(getAllergenCatReq){
            
        case .success(let allergenCatDTO):
            return .success(AllergenCategoryDAO.DTOtoAllergenCategory(dto: allergenCatDTO))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getIngredientByAllergen(id : Int) async ->Result<[Ingredient],Error> {
        
        let getIngredientByAllergenReq : Result<[IngredientGetDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "allergen-category/" + String(id) + "/ingredients")
        
        switch(getIngredientByAllergenReq){
            
        case .success(let ingredientDTO):
            return .success(IngredientDAO.DTOsToIngredients(dtos: ingredientDTO))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func postAllergenCategory(allergenCategory : AllergenCategory) async -> AllergenCategory?{
        
        let allergenCatDTO = AllergenCategorytoDTO(allergenCategory: allergenCategory)
        
        guard let url = URL(string: "https://awi-api.herokuapp.com/allergen-category") else {
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
            guard let encoded = await JSONHelper.encode(data: allergenCatDTO) else {
                print("GoRest: pb encodage")
                return nil
            }

            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                guard let decoded : AllergenCategoryDTO = JSONHelper.decode(data: data) else {
                    print("GoRest: mauvaise r??cup??ration de donn??es")
                    return nil
                }
                return AllergenCategoryDAO.DTOtoAllergenCategory(dto: decoded)
                
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
