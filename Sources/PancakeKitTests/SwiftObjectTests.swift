//
//  SwiftObjectTests.swift
//  PancakeKitTests
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import PancakeKit
@testable import SourceKittenFramework

class SwiftObjectTests: XCTestCase {
    var swiftObjects = [SwiftObject]()
    
    override func setUp() {
        super.setUp()
        
        let inPath = NSHomeDirectory() + "/Pancake/Sources/DemoKit"
        let module = Module(xcodeBuildArguments: ["-scheme", "DemoKit"], name: nil, inPath: inPath)
        if let docs = module?.docs {
            SwiftDocsParser.parse(SwiftDocs: docs)
        }
        swiftObjects = SwiftDocsParser.swiftObjects
    }
    
    override func tearDown() {
        swiftObjects = [SwiftObject]()
        super.tearDown()
    }

    func testSwiftObject() {
        if let file1 = swiftObjects.first?.substructure?.first {
            XCTAssertNotNil(file1)
        } else {
            XCTFail()
        }
    }
}
