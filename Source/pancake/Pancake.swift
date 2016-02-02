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
import PancakeKit

struct PancakeCommand: CommandType {
    let inPath = NSHomeDirectory() + "/Pancake/Source/DemoApp" // 仮
    
    typealias Options = PancakeOptions
    
    let verb = "pancake"
    let function = "generate doc"
    
    func run(options: PancakeOptions) -> Result<(), PancakeError> {
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoApp"], name: nil, inPath: inPath)
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
            return .Success()
        }
        return .Failure(.CommandError)
    }

    struct PancakeOptions: OptionsType {
        let isPublic: Bool
        
        static func create(isPublic: Bool) -> PancakeOptions {
            return PancakeOptions(isPublic: isPublic)
        }
        
        static func evaluate(m: CommandMode) -> Result<PancakeOptions, CommandantError<PancakeError>> {
            return create
                <*> m <| Option(key: "isPublic", defaultValue: false, usage: "USAGE")
        }
    }
}
