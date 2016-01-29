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
        XCTAssertNotNil(Markdown.propertiesTemplate)
        XCTAssertNotNil(Markdown.methodsTemplate)
        XCTAssertNotNil(Markdown.c_methodTemplate)
        XCTAssertNotNil(Markdown.c_commentTemplate)
        XCTAssertNotNil(Markdown.c_DeclarationTemplate)
        XCTAssertNotNil(Markdown.c_parametersTemplate)
        XCTAssertNotNil(Markdown.c_parameterTemplate)
        XCTAssertNotNil(Markdown.c_returnValueTemplate)
        XCTAssertNotNil(Markdown.c_seeAlsoTemplate)
        XCTAssertNotNil(Markdown.enumTemplate)
        XCTAssertNotNil(Markdown.enumDeclarationTemplate)
    }
    
    func testMethodMarkdownWithAll() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let methodMarkdownString = Markdown.classMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(methodMarkdownString.containsString("Declaration"))
        XCTAssertTrue(methodMarkdownString.containsString("TestDec"))
        XCTAssertTrue(methodMarkdownString.containsString("This is a test comment."))
        XCTAssertTrue(methodMarkdownString.containsString("Parameters"))
        XCTAssertTrue(methodMarkdownString.containsString("TestParameter"))
        XCTAssertTrue(methodMarkdownString.containsString("TestDiscussion"))
        XCTAssertTrue(methodMarkdownString.containsString("Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("TestResultDiscussion"))
        // TODO:
        //XCTAssertTrue(methodMarkdownString.containsString("See Also"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassParameters.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassReturnValue.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassSeeAlso.md%"))
    }
    
    func testMethodMarkdowntWithComment() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: "This is a test comment.",
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = Markdown.classMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertFalse(commentMarkdownString.containsString("This is a test comment."))
        XCTAssertFalse(commentMarkdownString.containsString("Parameters"))
        XCTAssertFalse(commentMarkdownString.containsString("Return Value"))
        XCTAssertFalse(commentMarkdownString.containsString("See Also"))
    }
    
    func testMethodMarkdownWithNameAndComment() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: "TestName",
            parsed_declaration: nil,
            doc_comment: "This is a test comment.",
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = Markdown.classMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.containsString("This is a test comment."))
        XCTAssertFalse(commentMarkdownString.containsString("Parameters"))
        XCTAssertFalse(commentMarkdownString.containsString("Return Value"))
        XCTAssertFalse(commentMarkdownString.containsString("See Also"))
    }
    
    func testMethodMarkdownString() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: nil,
            parameters: nil,
            result_discussion:[Discussion(para: "testReturnValue")],
            substructure: nil
        )
        var methodMarkdownString = Markdown.c_methodTemplate.stringByReplacingOccurrencesOfString("%name%", withString: "TestName")
        
        XCTAssertTrue(methodMarkdownString.containsString("%ClassComment.md%"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassComment.md%", withString: Markdown.classCommentMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))

        XCTAssertTrue(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassDeclaration.md%", withString: Markdown.classDeclarationMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        
        XCTAssertTrue(methodMarkdownString.containsString("%ClassParameters.md%"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassParameters.md%", withString: Markdown.classParametersMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassParameters.md%"))
        
        XCTAssertTrue(methodMarkdownString.containsString("%ClassReturnValue.md%"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassReturnValue.md%", withString: Markdown.classReturnValueMarkdownString(swiftObject))
        XCTAssertTrue(methodMarkdownString.containsString("Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("testReturnValue"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassParameters.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassReturnValue.md%"))
        
        XCTAssertTrue(methodMarkdownString.containsString("%ClassSeeAlso.md%"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassSeeAlso.md%", withString: Markdown.classSeeAlsoMarkdownString(swiftObject))
        XCTAssertTrue(methodMarkdownString.containsString("Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("testReturnValue"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassComment.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassDeclaration.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassParameters.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassReturnValue.md%"))
        XCTAssertFalse(methodMarkdownString.containsString("%ClassSeeAlso.md%"))
    }
    
    func testReturnValue() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: nil,
            parameters: nil,
            result_discussion: [Discussion(para: "testReturnValue")],
            substructure: nil
        )
        let resuleReturnValueString = Markdown.classReturnValueMarkdownString(swiftObject)
        XCTAssertTrue(resuleReturnValueString.containsString("Return Value"))
        XCTAssertTrue(resuleReturnValueString.containsString("testReturnValue"))
        XCTAssertFalse(resuleReturnValueString.containsString("%ClassComment.md%"))
        XCTAssertFalse(resuleReturnValueString.containsString("%ClassDeclaration.md%"))
        XCTAssertFalse(resuleReturnValueString.containsString("%ClassParameters.md%"))
        XCTAssertFalse(resuleReturnValueString.containsString("%ClassReturnValue.md%"))
        XCTAssertFalse(resuleReturnValueString.containsString("%ClassSeeAlso.md%"))
    }
}
