//
//  Demo3.swift
//  DemoKit
//
//  Created by JPMartha on 2016/02/23.
//  Copyright © 2016 JPMartha. All rights reserved.
//


enum DemoType {
    case iOS
    case OSX
}

let type = DemoType.iOS
if type != .OSX {
    print("test2")
}