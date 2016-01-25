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
        XCTAssertEqual(swiftFiles.count, 6)
    }
    
    func testSwiftClass() {
        if let class1 = swiftFiles.first?.substructure.first {
            XCTAssertEqual(class1.kind, "source.lang.swift.decl.class")
            XCTAssertEqual(class1.parsed_declaration, "class ViewController: NSViewController")
            XCTAssertEqual(class1.name, "ViewController")
            XCTAssertEqual(class1.accessibility, "source.lang.swift.accessibility.internal")
        } else {
            XCTFail()
        }
        
        let class2 = swiftFiles[2].substructure[1]
        XCTAssertEqual(class2.kind, "source.lang.swift.decl.class")
        XCTAssertEqual(class2.parsed_declaration, "public class Demo")
        XCTAssertEqual(class2.name, "Demo")
        XCTAssertEqual(class2.accessibility, "source.lang.swift.accessibility.public")
    }
    
    func testSwiftMethod() {
        if let method1 = swiftFiles[2].substructure[1].substructure?.first {
            XCTAssertEqual(method1.kind, "source.lang.swift.decl.function.method.instance")
            XCTAssertEqual(method1.parsed_declaration, "public func doAction(pram1: Int, pram2: String) -> Bool")
            XCTAssertEqual(method1.doc_comment!, "DoAction\n- parameters:\n  - pram1: aaa\n  - pram2: bbb\n- returns: true/false")
            XCTAssertEqual(method1.name, "doAction(_:pram2:)")
            XCTAssertEqual(method1.accessibility, "source.lang.swift.accessibility.public")
        } else {
            XCTFail()
        }
    }
}
