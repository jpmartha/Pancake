//
//  PublicCommand.swift
//  Pancake
//
//  Created by JPMartha on 2016/02/08.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import Commandant
import Result
import PancakeKit

struct PublicCommand: CommandType {
    let inPath = NSHomeDirectory() + "/Pancake/Source/DemoApp" // 仮
    
    typealias Options = PublicOptions
    
    let verb = "public"
    let function = "Public Only"
    
    func run(options: PublicOptions) -> Result<(), PancakeError> {
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoApp"], name: nil, inPath: inPath)
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
            return .Success()
        }
        return .Failure(.CommandError)
    }
    
    struct PublicOptions: OptionsType {
        let isPublic: Bool
        
        static func create(isPublic: Bool) -> PublicOptions {
            return PublicOptions(isPublic: isPublic)
        }
        
        static func evaluate(m: CommandMode) -> Result<PublicOptions, CommandantError<PancakeError>> {
            return create
                <*> m <| Option(key: "isPublic", defaultValue: false, usage: "USAGE")
        }
    }
}
