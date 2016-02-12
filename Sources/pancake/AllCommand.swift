//
//  AllCommand.swift
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

struct AllCommand: CommandType {
    
    typealias Options = PancakeOptions
    
    let verb = "all"
    let function = "Generate the documentation as Markdown format"
    
    func run(options: PancakeOptions) -> Result<(), PancakeError> {
        guard !options.scheme.isEmpty else {
            return .Failure(.CommandError)
        }
        return runPancake(options.scheme)
    }
    
    func runPancake(scheme: String) -> Result<(), PancakeError> {
        let module = Module(xcodeBuildArguments: ["-scheme", scheme], name: nil)
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
            SwiftDocsParser.outputMarkdown()
            print("＿人人人人人人人＿")
            print("＞　 Success!!　 ＜")
            print("￣Y^Y^Y^Y^Y^Y^Y￣")
            return .Success()
        }
        return .Failure(.CommandError)
    }

    struct PancakeOptions: OptionsType {
        let scheme: String
        
        static func create(scheme: String) -> PancakeOptions {
            return PancakeOptions(scheme: scheme)
        }
        
        static func evaluate(m: CommandMode) -> Result<PancakeOptions, CommandantError<PancakeError>> {
            return create
                <*> m <| Option(key: "scheme", defaultValue: "", usage: "scheme name")
        }
    }
}
