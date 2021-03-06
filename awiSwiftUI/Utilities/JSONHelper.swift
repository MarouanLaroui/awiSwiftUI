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
                print("decode error")
                return.failure(HTTPError.emptyResult)
            }
            catch(let error){
                print("catched error")
                return .failure(error)
            }
        }
        return .failure(HTTPError.badURL)
    }
    
    static func httpDelete(url : String) async -> Result<Int,Error>{
        
        guard let url = URL(string: url)
        else {return .failure(HTTPError.badURL)}
        
        do{
            var request = URLRequest(url: url)
            print(url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "DELETE"
 
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200 {
                
                guard let decoded : DeleteDTO = JSONHelper.decode(data: data)
                else {
                    print("Bad recovery of data")
                    return .failure(HTTPError.badRecoveryOfData)
                    
                }
                return .success(decoded.affected)
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
        
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: extensionStr){ // parame??tres de type String
            if let content = try? Data(contentsOf: fileURL) { // donne??e de type Data (buffer d'octets)
                return content
          }
            
        }
        return nil
    }
    
    
    static func loadJsonFromFile(filename: String, ext: String)-> Result<Data, JSONError>{ // Data si succe??s, JSONError sinon
        
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext)
            else {return .failure(.fileNotFound(filename+"."+ext)) }
        guard let content = try? Data(contentsOf: fileURL)
            else {return .failure(.JsonDecodingFailed)}
      return .success(content)
    }
    
    
    static func encode<T: Encodable>(data: T) async -> Data?{
        
        let encoder = JSONEncoder() // cre??ation d'un de??codeur
        do {
            return try encoder.encode(data)
        } catch {
            return nil
        }
    }
    
    static func decode<T: Decodable>(data: Data) -> T?{
        
        let decoder = JSONDecoder() // cre??ation d'un de??codeur
        if let decoded = try? decoder.decode(T.self, from:data) {
            // si on a re??ussit a?? de??coder self.tracks = decoded
            return decoded
        }
        return nil
    }
    
    static func decodeList<T: Decodable>(data: Data) -> [T]?{
        
        let decoder = JSONDecoder() // cre??ation d'un de??codeur
        if let decoded = try? decoder.decode([T].self, from:data) {
            // si on a re??ussit a?? de??coder self.tracks = decoded
            return decoded
        }
        return nil
    }
}
