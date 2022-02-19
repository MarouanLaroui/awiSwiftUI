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
    
}
