//
//  SwiftDocsParserTests.swift
//  PancakeKitTests
//
//  Created by JPMartha on 2016/02/11.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import PancakeKit
@testable import SourceKittenFramework

class SwiftDocsParserTests: XCTestCase {
    func testOutputMarkdown() {
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoKit"], name: nil, inPath: NSHomeDirectory() + "/Pancake/Sources/DemoKit")
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
            let outPath = NSHomeDirectory() + "/Pancake/Sources/DemoKit/Pancake/Documentation"
            SwiftDocsParser.outputMarkdown(outPath)
        }
    }
}
