//
//  MarkdownTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import Pancake

class MarkdownTests: XCTestCase {
    func testMarkdownTemplate() {
        XCTAssertNotNil(Markdown.classTemplate)
        XCTAssertNotNil(Markdown.methodTemplate)
        XCTAssertNotNil(Markdown.commentTemplate)
        XCTAssertNotNil(Markdown.declarationTemplate)
        XCTAssertNotNil(Markdown.parametersTemplate)
        XCTAssertNotNil(Markdown.returnValueTemplate)
        XCTAssertNotNil(Markdown.seeAlsoTemplate)
    }
}
