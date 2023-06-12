//
//  UserCodableApi.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import Foundation

class UserCodableApi {
    
    static let shared: UserCodableApi = UserCodableApi()
    
    private let usersUrl = "https://reqres.in/api/users"
    private let registerUrl = "https://reqres.in/api/register"
    
    private init() { }
    
    func getUsers(completionHandler: @escaping (_ data: UserList?, _ error: Error?) -> ()) {
        guard var url = URL(string: usersUrl) else { return }
        
        url.append(queryItems: [URLQueryItem(name: "per_page", value: "10")])
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // TODO: - decoder.keyDecodingStrategy = .convertFromSnakeCase fix not working
                if let userList = try? decoder.decode(UserList.self, from: data) {
                    completionHandler(userList, nil)
                }
            }
        }.resume()
    }
    
    func registerUser(user: UserRegister, completion: @escaping (Result<RegisterResponse, ApiError>) -> ()) {
        ApiManager.shared.call(url: registerUrl, method: "POST", body: user, completion: completion)
    }
    
    func deleteUser(userId: Int, completion: @escaping (Result<BaseResponse<DefaultCodable>, ApiError>) -> ()) {
        ApiManager.shared.call(url: "\(usersUrl)/\(userId)", method: "DELETE", completion: completion)
    }
}
