//
//  Demo.swift
//  DemoApp
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

let constant: String = "This is a constant."

public enum TestEnumerationType {
    case Enumeration0
    case Enumeration1
}

struct DemoStruct {
    let p1: Int = 0
    let p2: String = "0"
}

public class Demo {
    let string = "This is String."
    
    /**
    DoAction
    - parameters:
      - pram1: aaa
      - pram2: bbb
    - returns: true/false
    - seealso:
      [The Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios//documentation/General/Reference/SwiftStandardLibraryReference/index.html)
    */
    public func doAction(param1: Int, param2: String) -> Bool {
        return true
    }
    
    /**
     DoAction2
     - parameter para: p1
     */
    public func doAction2(para p1: Int) {
        return true
    }
}
