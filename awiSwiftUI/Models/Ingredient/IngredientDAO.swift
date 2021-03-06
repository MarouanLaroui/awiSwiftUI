//
//  IngredientDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct IngredientDAO{
    
    static func getDTOtoDict(dtos : [IngredientGetDTO])->[Ingredient:Int]{
        var dict :[Ingredient:Int] = [:]
        dtos.forEach({
            if let quantity = $0.quantity {
            
                dict[IngredientDAO.GetDTOtoIngredient(dto: $0)] = quantity
            }
            else{
                dict[IngredientDAO.GetDTOtoIngredient(dto: $0)] = 0
            }
            
        })
        return dict
    }
    
    static func getTotalIngredients(recipeId : Int)async ->Result<[Ingredient:Int],Error> {
        
        let getIngredientTask : Result<[IngredientGetDTO],Error> = await JSONHelper.httpGet(url: Utils.apiURL + "recipe/" + String(recipeId) + "/ingredients/total")
        
        switch(getIngredientTask){
            
        case .success(let ingredientDTOs):
            return .success(IngredientDAO.getDTOtoDict(dtos: ingredientDTOs))
            
            
        case .failure(let error):
            return .failure(error)
        }
    
    }
    static func IngredientToDTO(ingredient : Ingredient)->IngredientPostDTO{
        
        return IngredientPostDTO(
            id : ingredient.id,
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
    
    static func PostDTOtoIngredient(dto : IngredientPostDTO) async ->Result<Ingredient,Error>{
        
        var resCategory : IngredientCategory
        var resAllergen : AllergenCategory? = nil
        var resUnity : Unity
        
        async let category = IngredientCategoryDAO.getIngredientCategory(id: dto.category)
        async let unity = UnityDAO.getUnit(id: dto.unity)
        
        switch(await category){
            
        case .success(let ingredientCat):
            resCategory = ingredientCat
            
        case .failure(let err):
            return .failure(err)
        }
        
        switch(await unity){
            
        case .success(let ingredientUnity):
            resUnity = ingredientUnity
            
        case .failure(let err):
            return .failure(err)
        }
        
        
        if let allergenId = dto.allergen{
            async let allergen = AllergenCategoryDAO.getAllergenCategory(id: allergenId)
            
            switch(await allergen){
                
            case .success(let ingredientAllergen):
                resAllergen = ingredientAllergen
                
            case .failure(let err):
                return .failure(err)
            }
        }
        
        return .success(Ingredient(
            name: dto.name,
            unitaryPrice: Double(dto.unitaryPrice),
            nbInStock: Double(dto.nbInStock),
            allergen: resAllergen,
            ingredientCategory: resCategory,
            unity: resUnity
        ))
        
        
        
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
    
    
    
    static func postIngredient(ingredient : Ingredient) async -> Result<Ingredient,Error>{
        
        let ingredientDTO = IngredientDAO.IngredientToDTO(ingredient: ingredient)
        guard let url = URL(string: "https://awi-api.herokuapp.com/ingredient")
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            guard let encoded = await JSONHelper.encode(data: ingredientDTO) else {
                return .failure(JSONError.JsonEncodingFailed)
            }
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 201{
                
                guard let decoded : IngredientPostDTO = JSONHelper.decode(data: data)
                else {
                    return .failure(HTTPError.badRecoveryOfData)
                    
                }
                let res = await IngredientDAO.PostDTOtoIngredient(dto: decoded)
                
                switch(res){
                case .success(let ingr):
                    return .success(ingr)
                case .failure(let err):
                    return .failure(err)
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
}
