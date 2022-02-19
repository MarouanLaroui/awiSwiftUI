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
            id: ingredient.id,
            name: ingredient.name,
            unitaryPrice: ingredient.unitaryPrice,
            nbInStock: ingredient.nbInStock,
            allergen: ingredient.allergen?.id,
            category: ingredient.category.id!,
            unity:ingredient.unity.id
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
    
    
    static func postIngredient(ingredient : Ingredient) async -> Ingredient?{
        
        let ingredientDTO = IngredientDAO.IngredientToDTO(ingredient: ingredient)
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
            print(err.localizedDescription)
        }
        return nil
    }
}
