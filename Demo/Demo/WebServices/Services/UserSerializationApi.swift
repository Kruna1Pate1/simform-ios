//
//  UserSerializationApi.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import Foundation

class UserSerializationApi {
    
    static let shared: UserSerializationApi = UserSerializationApi()
    
    private let url = "https://reqres.in/api/users"
    
    private init() { }
    
    func getUsers(completionHandler: @escaping (_ data: UserList?, _ error: Error?) -> ()) {
        guard var url = URL(string: url) else { return }
        
        url.append(queryItems: [URLQueryItem(name: "delay", value: "10"), URLQueryItem(name: "per_page", value: "10")])
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
                
                var userList = UserList()
                
                if let page = json["page"] as? Int {
                    userList.page = page
                }
                
                if let perPage = json["per_page"] as? Int {
                    userList.perPage = perPage
                }
                
                if let total = json["total"] as? Int {
                    userList.total = total
                }
                
                if let totalPages = json["total_pages"] as? Int {
                    userList.totalPages = totalPages
                }
                
                if let usersJson = json["data"] as? [[String:Any]] {
                    
                    for item in usersJson {
                        var user = User()
                        
                        if let id = item["id"] as? Int {
                            user.id = id
                        }
                        if let firstName = item["first_name"] as? String {
                            user.firstName = firstName
                        }
                        if let lastName = item["last_name"] as? String {
                            user.lastName = lastName
                        }
                        if let email = item["email"] as? String {
                            user.email = email
                        }
                        if let avatar = item["avatar"] as? String {
                            user.avatar = avatar
                        }
                        userList.users.append(user)
                    }
                    completionHandler(userList, nil)
                }
            }
        }
        dataTask.resume()
    }
}
