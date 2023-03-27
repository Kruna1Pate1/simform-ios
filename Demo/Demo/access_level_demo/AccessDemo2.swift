//
//  AccessDemo2.swift
//  Demo
//
//  Created by Krunal Patel on 03/03/23.
//

import Foundation

class AccessDemo2 {
    
    var openClass = OpenClass()
    var publicClass = PublicClass()
    var internalClass = InternalClass()
//    Not accessible properties
//    let fpClass = fileprivateFunc()
//    let pvtClass = PrivateClass()
    
    init() {
        openClass.openVar = "open"
        
//        Cannot assign to property: 'publicVar' setter is inaccessible
//        openClass.publicVar = "public"
        print(openClass.publicVar)
        
//        'fpVar' is inaccessible due to 'fileprivate' protection level
//        openClass.fpVar = "fileprivate"
//        'privateVar' is inaccessible due to 'private' protection level
//        openClass.privateVar = "private"
    }
}

class NewInternalClass: InternalClass {
    override func openFunc() -> String {
        "NewOpenFunc"
    }
    
    override func publicFunc() -> String {
        "NewPublicFunc"
    }
    
    // Method does not override any method from its superclass
//    override fileprivate func filePrivateFunc() -> String {
//        "fileprivate"
//    }
    
    private func privateFunc() -> String {
        "NewPrivate"
    }
}


fileprivate protocol FPProtocol {
//    'public' modifier cannot be used in protocols
//    public func public() -> String
    
//    'private' modifier cannot be used in protocols
//    private func private() -> String
    
//    'fileprivate' modifier cannot be used in protocols
//    fileprivate func fpFunc() -> String
    
    func fpFunc() -> String
}

public protocol OpenProtocol {
    func openFunc() -> String
}


extension InternalClass: FPProtocol, OpenProtocol {
    var newPublicVar: String {
//        'privateVar' is inaccessible due to 'private' protection level
//        privateVar
        publicVar
    }
    
    func fpFunc() -> String {
        "NewFpFunc"
    }

}
