//
//  LoginRequest.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

// MARK: - Login
struct LoginRequest: Codable {
    var usernmame: String? = nil
    var password: String? = nil
}

struct LoginResponse: Codable {
    var token: String? = nil
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description, category: String?
    let image: String?
    let rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

// MARK: - Category
struct Category: Codable {
    let categories: [String]?
}
