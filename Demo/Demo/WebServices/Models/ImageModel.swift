//
//  ImageModel.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import Foundation

struct ImageUploadRequest: Codable {
    var key: String = "image"
    var value: String?
}

// MARK: - ImageUploadResponse
struct ImageUploadResponse: Codable {
    let data: DataClass?
    let success: Bool?
    let status: Int?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, title: String?
    let urlViewer: String?
    let url, displayURL: String?
    let width, height, size, time: Int?
    let expiration: Int?
    let image, thumb, medium: Image?
    let deleteURL: String?
}

// MARK: - Image
struct Image: Codable {
    let filename, name, mime, imageExtension: String?
    let url: String?
}

