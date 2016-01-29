//
//  MarkdownTemplateTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import Pancake

class TemplateTests: XCTestCase {
    func testClassTemplate() {
        let template = MarkdownTemplate(fileName: "Class.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("%name%"))
        XCTAssertTrue(template.markdownString.containsString("Methods"))
    }
    
    func testMethodsTemplate() {
        let template = MarkdownTemplate(fileName: "ClassMethod.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("`%name%`"))
        XCTAssertTrue(template.markdownString.containsString("%ClassComment.md%"))
        XCTAssertTrue(template.markdownString.containsString("%ClassDeclaration.md%"))
        XCTAssertTrue(template.markdownString.containsString("%ClassParameters.md%"))
        XCTAssertTrue(template.markdownString.containsString("%ClassReturnValue.md%"))
        XCTAssertTrue(template.markdownString.containsString("%ClassSeeAlso.md%"))
    }
    
    func testCommentTemplate() {
        let template = MarkdownTemplate(fileName: "ClassComment.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("%doc_comment%"))
    }
    
    func testMethodDeclarationTemplate() {
        let template = MarkdownTemplate(fileName: "ClassDeclaration.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Declaration"))
        XCTAssertTrue(template.markdownString.containsString("```swift\n  %parsed_declaration%\n  ```"))
    }
    
    func testParametersTemplate() {
        let template = MarkdownTemplate(fileName: "ClassParameters.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Parameters"))
        XCTAssertTrue(template.markdownString.containsString("%parameters%"))
    }
    
    func testParameterTemplate() {
        let template = MarkdownTemplate(fileName: "ClassParameter.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("%parameter_name%"))
        XCTAssertTrue(template.markdownString.containsString("%parameter_description%"))
    }
    
    func testReturnValueTemplate() {
        let template = MarkdownTemplate(fileName: "ClassReturnValue.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Return Value"))
        XCTAssertTrue(template.markdownString.containsString("%result_discussion%"))
    }
    
    func testSeeAlsoTemplate() {
        let template = MarkdownTemplate(fileName: "ClassSeeAlso.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("See Also"))
        XCTAssertTrue(template.markdownString.containsString("%see_also%"))
    }
    
    func testEnumTemplate() {
        let template = MarkdownTemplate(fileName: "Enumeration.md")
        XCTAssertNotNil(template)
    }
    
    func testEnumDeclarationTemplate() {
        let template = MarkdownTemplate(fileName: "EnumerationDeclaration.md")
        XCTAssertNotNil(template)
    }
}
