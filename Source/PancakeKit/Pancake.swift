//
//  Pancake.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/20.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import Commandant
import Result

public final class Pancake {
    static let inPath = NSHomeDirectory() + "/Pancake/DemoApp"

    public static func docs() {
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoApp"], name: nil, inPath: inPath)
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
        }
    }
}
