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
    
    func testSwiftFileCount() {
        XCTAssertEqual(swiftFiles.count, 2)
    }
    
    func testSwiftObject() {
        
        XCTAssertEqual(swiftFiles.first?.substructure.first?.kind, "source.lang.swift.decl.enum")
        XCTAssertEqual(swiftFiles.first?.substructure.first?.parsed_declaration, "enum TestEnumerationType")
        XCTAssertEqual(swiftFiles.first?.substructure.first?.name, "TestEnumerationType")
        XCTAssertEqual(swiftFiles.first?.substructure.first?.accessibility, "source.lang.swift.accessibility.internal")
        
        XCTAssertEqual(swiftFiles.first?.substructure[1].kind, "source.lang.swift.decl.class")
        XCTAssertEqual(swiftFiles.first?.substructure[1].parsed_declaration, "class ViewController: NSViewController")
        XCTAssertEqual(swiftFiles.first?.substructure[1].name, "ViewController")
        XCTAssertEqual(swiftFiles.first?.substructure[1].accessibility, "source.lang.swift.accessibility.internal")
    }
}
