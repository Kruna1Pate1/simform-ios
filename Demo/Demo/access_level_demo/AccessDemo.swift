//
//  AccessDemo.swift
//  Demo
//
//  Created by Krunal Patel on 02/03/23.
//

import Foundation

class AccessDemo {
    
    open var openVar = "open"
    public var publicVar = "public"
    internal let internalVar = "internal"
    fileprivate let fpVar = "fileprivate"
    private var privateVar = "private"
    
    
    open func openFunc() -> String {
        "open"
    }
    
    public func publicFunc() -> String {
        "public"
    }
    
    internal func internalFunc() -> String {
        "internal"
    }
    
    fileprivate func fileprivateFunc() -> String {
        "fileprivate"
    }
    
    private func privateFunc() -> String {
        "private"
    }
}

open class OpenClass {
    
    open var openVar = "open"
    public fileprivate(set) var publicVar = "public"
    internal let internalVar = "internal"
    fileprivate let fpVar = "fileprivate"
    private var privateVar = "private"
    
    
    // Method cannot be declared open because its parameter uses a private type
    open func openFunc(publicClass: PublicClass /*, privateClass: PrivateClass */) -> String {
        "fileprivate"
    }
    
    public func publicFunc() -> String {
        "public"
    }
    
    internal func internalFunc() -> String {
        "internal"
    }
    
    fileprivate func fileprivateFunc() -> String {
        "fileprivate"
    }
    
    private func privateFunc() -> String {
        "private"
    }
}

public class PublicClass {
    
    open var openVar = "open"
    public var publicVar = "public"
    internal let internalVar = "internal"
    fileprivate let fpVar = "fileprivate"
    private var privateVar = "private"
    
    
    open func openFunc() -> String {
        "open"
    }
    
    public func publicFunc() -> String {
        "public"
    }
    
    internal func internalFunc() -> String {
        "internal"
    }
    
    fileprivate func fileprivateFunc() -> String {
        "fileprivate"
    }
    
    private func privateFunc() -> String {
        "private"
    }
}

internal class InternalClass {
    
    open var openVar = "open"
    public var publicVar = "public"
    internal let internalVar = "internal"
    fileprivate let fpVar = "fileprivate"
    private var privateVar = "private"
    
    
    open func openFunc() -> String {
        "open"
    }
    
    public func publicFunc() -> String {
        "public"
    }
    
    internal func internalFunc() -> String {
        "internal"
    }
    
    fileprivate func filePrivateFunc() -> String {
        "fileprivate"
    }
    
    private func privateFunc() -> String {
        "private"
    }
}

fileprivate class FilePrivateClass {
    
    fileprivate func fileprivateFunc(publicClass: PublicClass, privateClass: PrivateClass) -> String {
        "fileprivate"
    }
    
    private func privateFunc() -> String {
        "private"
    }
    
    let internalClass = InternalClass()
    
    init() {
        internalClass.filePrivateFunc()
//        Non accessible property
//        internalClass.privateFunc()
    }
}

private class PrivateClass {
    
    fileprivate func fileprivateFunc() -> String {
        "fileprivate"
    }
    
    fileprivate func privateFunc(publicClass: PublicClass, privateClass: PrivateClass) -> String {
        "fileprivate"
    }
}


