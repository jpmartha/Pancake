//
//  WriteToFileTests.swift
//  Pancake
//
//  Created by JPMartha on 2016/02/10.
//  Copyright © 2016年 JPMartha. All rights reserved.
//

import XCTest
@testable import PancakeKit

class WriteToFileTests: XCTestCase {
    let documentationPath = "/Pancake/Source/DemoKit/Pancake/Documentation"
    var demoGlobalContents: String = ""
    var demoEnumerationContents: String = ""
    var demoClassContents: String = ""
    var demoStructureContents: String = ""

    override func setUp() {
        super.setUp()
        
        let demoGlobalFilePath = NSHomeDirectory() + documentationPath + "/Global.md"
        do {
            demoGlobalContents = try String(contentsOfFile: demoGlobalFilePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            demoGlobalContents = ""
            XCTFail()
        }
        
        let demoEnumerationFilePath = NSHomeDirectory() + documentationPath + "/DemoTypeEnumeration.md"
        do {
            demoEnumerationContents = try String(contentsOfFile: demoEnumerationFilePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            demoEnumerationContents = ""
            XCTFail()
        }
        
        let demoClassFilePath = NSHomeDirectory() + documentationPath + "/DemoClass.md"
        do {
            demoClassContents = try String(contentsOfFile: demoClassFilePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            demoClassContents = ""
            XCTFail()
        }
        
        let demoStructureFilePath = NSHomeDirectory() + documentationPath + "/SuffleStructure.md"
        do {
            demoStructureContents = try String(contentsOfFile: demoStructureFilePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            demoStructureContents = ""
            XCTFail()
        }
    }

    func testDemoGlobalContents() {
        XCTAssertFalse(demoGlobalContents.containsString("%"))
    }
    
    func testDemoEnumerationContents() {
        XCTAssertFalse(demoEnumerationContents.containsString("%"))
    }
    
    func testDemoClassContents() {
        XCTAssertFalse(demoClassContents.containsString("%"))
    }
    
    func testDemoStructureContents() {
        XCTAssertFalse(demoStructureContents.containsString("%"))
    }
}
