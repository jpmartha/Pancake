//
//  SwiftMarkdownTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest

class SwiftMarkdownTests: XCTestCase {
    
    func testReadMarkdown() {
        guard let methodMarkdownPath = NSBundle(forClass: self.dynamicType).pathForResource("Methods", ofType: "md") else {
            XCTFail("MethodMarkdownPath is invalid.")
            return
        }
        
        let markdownString: String
        do {
            markdownString = try String(contentsOfFile: methodMarkdownPath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            XCTFail(error.debugDescription)
            return
        }
        
        let m = markdownString.stringByReplacingOccurrencesOfString("%name%", withString: "Name")
        print(m)
    }
}
