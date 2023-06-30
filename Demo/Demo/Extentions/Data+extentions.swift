//
//  Data+extentions.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import Foundation

extension Data {
    mutating func append(_ s: String) {
        self.append(s.data(using: .utf8)!)
    }
}
