//
//  UserDAO.swift
//  IOSawi
//
//  Created by Marouan Laroui  on 18/02/2022.
//

import Foundation

struct UserDAO{
    
    static var access_token : String? = nil
    
    static func userToDTO(user : User)->UserDTO{
        return UserDTO(id: user.id, name: user.name, last_name: user.last_name, mail: user.mail, phone: user.phone, birthdate: user.birthdate, isAdmin: user.isAdmin)
    }
    
    static func dtoToUser(dto : UserDTO)->User{
        return User(id: dto.id, name: dto.name, last_name: dto.last_name, mail: dto.mail, phone: dto.phone, isAdmin: dto.isAdmin, birthdate: dto.birthdate)
    }
    
    static func dtosToUsers(dtos: [UserDTO]) -> [User]{
        var users : [User] = []
        dtos.forEach({
            users.append(UserDAO.dtoToUser(dto:$0))
        })
        return users
    }
    
    /*REQUESTS*/
    static func getUsers() async -> Result<[User], Error> {
        let getUsersTask : Result<[UserDTO], Error> = await JSONHelper.httpGet(url: Utils.apiURL + "user")
        
        switch(getUsersTask){
        case .success(let userDTOs):
            return .success(UserDAO.dtosToUsers(dtos: userDTOs))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    static func getUser(mail: String) async -> Result<User, Error> {
        let getUserTask : Result<UserDTO, Error> = await JSONHelper.httpGet(url: Utils.apiURL + "user/" + mail)
        
        switch(getUserTask){
        case .success(let userDTO):
            return .success(UserDAO.dtoToUser(dto: userDTO))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func postUser(userDTO: UserDTO) async -> Result<User, Error> {
        //User fictif pour les tests
        //let user = User.users[0]
        
        //let userDTO = UserDAO.userToDTO(user: user)
        
        //Construction de l'url
        guard let url = URL(string: Utils.apiURL + "user") else {
            return .failure(HTTPError.badURL)
        }
        
        do{
            var request = URLRequest(url: url)
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue("NoAuth", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            // set (replace) a value to a field
            //request.setValue("Bearer 1ccac66927c25f08de582f3919708e7aee6219352bb3f571e29566dd429ee0f0", forHTTPHeaderField: "Authorization")
            
            
            guard let encoded = await JSONHelper.encode(data: userDTO) else {
                return .failure(JSONError.JsonEncodingFailed)
            }
            
            //Pour les tests
            //let datatest = "{\"name\":\"Fiorio\",\"last_name\":\"Christophe\",\"mail\":\"marouanlarouicode@gmail.com\",\"phone\":\"0658003255\",\"birthdate\":\"2022-01-21\",\"isAdmin\":true,\"password\":\"a9ahvd0t\"}".data(using: .utf8)!
            //let (data, response) = try await URLSession.shared.upload(for: request, from: datatest)
            
            //Upload
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //traitement de la valeur de retour
            let httpresponse = response as! HTTPURLResponse
            
            if httpresponse.statusCode == 201{
                guard let decoded : UserDTO = JSONHelper.decode(data: data) else {
                    return .failure(HTTPError.emptyDTO)
                }
                return .success(UserDAO.dtoToUser(dto: decoded))
                
                //self.users.append(decoded.data)
            }
            else{
                return .failure(HTTPError.error(httpresponse))
            }
        }
        catch(let error){
            //Bad request
            return .failure(error)
        }
    }
    
    
    static func login(mail: String, password : String) async -> Result<User, Error> {
        
        let loginDTO = UserLoginDTO(mail: mail, password: password)
        print(loginDTO)
        //Construction de l'url
        guard let url = URL(string: Utils.apiURL + "auth/login") else {
            return .failure(HTTPError.badURL)
        }
        
        do{
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            guard let encoded = await JSONHelper.encode(data: loginDTO)
            else {return .failure(JSONError.JsonEncodingFailed)}
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let httpresponse = response as! HTTPURLResponse
            
            if httpresponse.statusCode == 201{
                
                guard let decoded : UserDTO = JSONHelper.decode(data: data)
                else {return .failure(HTTPError.emptyDTO)}
                self.access_token = decoded.access_token
                
                if(access_token != nil){
                    KeychainHelper.standard.saveJWT(token: access_token!)
                }
                return .success(UserDAO.dtoToUser(dto: decoded))
            }
            else{
                print(httpresponse.statusCode)
                return .failure(HTTPError.error(httpresponse))
            }
        }
        catch(let error){
            //Bad request
            return .failure(error)
        }
    }
    
}
