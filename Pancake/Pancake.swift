//
//  Pancake.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/20.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

public class Pancake {
    
    static let testPath = NSHomeDirectory() + "/Pancake/DemoApp"

    public static func docs() {
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoApp"], name: nil, inPath: testPath)
        
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
        }
    }
}
