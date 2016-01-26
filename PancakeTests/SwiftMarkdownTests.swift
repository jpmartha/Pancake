//
//  SwiftMarkdownTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import Pancake

class SwiftMarkdownTests: XCTestCase {

    func testSwiftMarkdownTemplate() {
        XCTAssertNotNil(SwiftMarkdown.classTemplate)
        XCTAssertNotNil(SwiftMarkdown.methodTemplate)
        XCTAssertNotNil(SwiftMarkdown.commentTemplate)
        XCTAssertNotNil(SwiftMarkdown.declarationTemplate)
        XCTAssertNotNil(SwiftMarkdown.parametersTemplate)
        XCTAssertNotNil(SwiftMarkdown.returnValueTemplate)
        XCTAssertNotNil(SwiftMarkdown.seeAlsoTemplate)
    }
}
