//
//  Demo.swift
//  DemoKit
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

/// This is a constant.
let demoConstant: Int = 9
/// This is a variable.
var demoVariable: String = "Demonstration"

/// This is a enumeration.
public enum EnumType {
    case Enum0
    case Enum1
}

/// This is a structure.
struct Suffle {
    let p1 = 0
    var p2: String?
}

/// This is a class.
public class Demo {
    /// This is a string.
    let string = "String"
    
    /// This is a enumeration.
    enum DemoType {
        case iOS
        case OSX
    }
    
    /// This is a enumeration.
    enum DemoType2 {
        case watchOS
        case tvOS
    }
    
    /**
    This is a method.
    - parameters:
      - pram1: aaa
      - pram2: bbb
    - returns: true/false
    - seealso:
      [The Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios//documentation/General/Reference/SwiftStandardLibraryReference/index.html)
    */
    public func demoAction(param1: Int, param2: String) -> Bool {
        return true
    }
    
    /**
    This is a method.
    - parameter para: p1
    */
    public func demoAction2(para p1: Int) {
        return
    }
}

/// This is a Boolean Value.
let isDemo: Bool = true
