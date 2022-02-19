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
    static func getIngredients()async ->[Ingredient]? {
        if let url = URL(string: Utils.apiURL + "ingredient") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : [IngredientGetDTO] = JSONHelper.decodeList(data: data) {
                    return IngredientDAO.DTOsToIngredients(dtos: dtos)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
    static func getIngredient(id : Int)async ->Ingredient? {
        if let url = URL(string: Utils.apiURL + "ingredient/:" + String(id)) {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dto : IngredientGetDTO = JSONHelper.decode(data: data) {
                    return IngredientDAO.GetDTOtoIngredient(dto: dto)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
}
