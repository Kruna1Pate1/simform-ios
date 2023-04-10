//
//  Dictionary+byIndex.swift
//  Demo
//
//  Created by Krunal Patel on 10/04/23.
//

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
