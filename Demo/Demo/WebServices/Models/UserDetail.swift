//
//  UserList.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import Foundation

struct UserList: Decodable {
    
    var page: Int = 0
    var perPage: Int = 0
    var total: Int = 0
    var totalPages: Int = 0
    
    var users: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case page, total
        case perPage = "per_page"
        case totalPages = "total_pages"
        case users = "data"
    }
}

struct User: Decodable {
    var id: Int = 0
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
//    var avtar: URL?
    var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct UserRegister: Codable {
    var email: String = ""
    var password: String = ""
}

struct RegisterResponse: Codable {
    var id: Int = 0
    var token: String = ""
}

class UserDeleteResponse: BaseResponse<DefaultCodable> {
}
