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
    static func getAllergens()async ->[AllergenCategory]? {
        if let url = URL(string: Utils.apiURL + "allergen") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : [AllergenCategoryDTO] = JSONHelper.decodeList(data: data) {
                    return AllergenCategoryDAO.DTOsToAllergenCategories(dtos: dtos)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
    static func getAllergen(id : Int)async ->AllergenCategory? {
        if let url = URL(string: Utils.apiURL + "allergen-category/:" + String(id)) {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dto : AllergenCategoryDTO = JSONHelper.decode(data: data) {
                    return AllergenCategoryDAO.DTOtoAllergenCategory(dto: dto)
                }
                
            }
            catch{
                
            }
        }
        
        return nil
    }
    
}
