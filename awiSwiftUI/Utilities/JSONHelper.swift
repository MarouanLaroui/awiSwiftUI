//
//  JSONHelper.swift
//  ListAndNavigation
//
//  Created by Marouan Laroui  on 16/02/2022.
//

import Foundation

struct JSONHelper{
    
    static func httpGet<T:Decodable>(url : String) async -> Result<T,Error>{
        if let url = URL(string: url) {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : T = JSONHelper.decode(data: data){
                    return .success(dtos)
                }
                return.failure(HTTPError.emptyResult)
            }
            catch(let error){
                return .failure(error)
            }
        }
        return .failure(HTTPError.badURL)
    }
    
    /*
    static func httpGet<T:Decodable>(url : String) async -> T?{
        if let url = URL(string: "oorufuofvhojrh") {
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                if let dtos : T = JSONHelper.decode(data: data) {
                    return dtos
                }
            }
            catch{
                
            }
        }
        
        return nil
    }
     */
    
    
    static func encodeInFile<T:Codable>(data : T,fileName : String, fileExtension : String){
        
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension){
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let json = try? encoder.encode(data)
            guard let jsonData = json else {
                print("json is empty")
                return
                
            }
            do{
                try jsonData.write(to: fileURL)
            }
            catch(_){
                print("erreur")
            }
            
            print("readfile is a success")
        }
        else{
            print("failto readfile")
        }
        
    }
    

    static func loadFromFile(filename:String, extensionStr: String)-> Data?{
        
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: extensionStr){ // paramètres de type String
            if let content = try? Data(contentsOf: fileURL) { // donnée de type Data (buffer d'octets)
                return content
          }
            
        }
        return nil
    }
    
    
    static func loadJsonFromFile(filename: String, ext: String)-> Result<Data, JSONError>{ // Data si succès, JSONError sinon
        
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext)
            else {return .failure(.fileNotFound(filename+"."+ext)) }
        guard let content = try? Data(contentsOf: fileURL)
            else {return .failure(.JsonDecodingFailed)}
      return .success(content)
    }
    
    
    static func encode<T: Encodable>(data: T) async -> Data?{
        
        let encoder = JSONEncoder() // création d'un décodeur
        do {
            return try encoder.encode(data)
        } catch {
            print("l'erreur elle est la gros")
            return nil
        }
    }
    
    static func decode<T: Decodable>(data: Data) -> T?{
        
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode(T.self, from:data) {
            // si on a réussit à décoder self.tracks = decoded
            return decoded
        }
        return nil
    }
    
    static func decodeList<T: Decodable>(data: Data) -> [T]?{
        
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode([T].self, from:data) {
            // si on a réussit à décoder self.tracks = decoded
            return decoded
        }
        return nil
    }
}
