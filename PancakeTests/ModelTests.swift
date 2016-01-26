//
//  ModelTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import Pancake

class ModelTests: XCTestCase {
    
    var swiftFiles = [SwiftFile]()
    
    override func setUp() {
        super.setUp()
        Pancake.docs()
        swiftFiles = SwiftDocsParser.swiftFiles
    }
    
    override func tearDown() {
        swiftFiles = [SwiftFile]()
        super.tearDown()
    }
    
    func testSwiftFile() {
        XCTAssertEqual(swiftFiles.count, 3)
        if let file1 = swiftFiles.first?.substructure.first {
            XCTAssertEqual(file1.kind, "source.lang.swift.decl.class")
            XCTAssertEqual(file1.parsed_declaration, "class ViewController: NSViewController")
            XCTAssertEqual(file1.name, "ViewController")
            XCTAssertEqual(file1.accessibility, "source.lang.swift.accessibility.internal")
        } else {
            XCTFail()
        }
        
        if let file2 = swiftFiles[1].substructure.first {
            XCTAssertEqual(file2.kind, "source.lang.swift.decl.class")
            XCTAssertEqual(file2.parsed_declaration, "class AppDelegate: NSObject, NSApplicationDelegate")
            XCTAssertEqual(file2.name, "AppDelegate")
            XCTAssertEqual(file2.accessibility, "source.lang.swift.accessibility.internal")
        } else {
            XCTFail()
        }
    }
}
