//
//  MarkdownTests.swift
//  PancakeKitTests
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import PancakeKit

class MarkdownTests: XCTestCase {
    func testGlobalVariablesMarkdownStringWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let markdownString = MarkdownGenerator.globalMarkdownStringWithSwiftObject(swiftObject)
        XCTAssertTrue(markdownString.containsString(" Declaration"))
        XCTAssertFalse(markdownString.containsString("%"))
    }
    
    func testGlobalEnumerationsMarkdownStringWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let markdownString = MarkdownGenerator.globalEnumerationMarkdownStringWithSwiftObject(swiftObject)
        XCTAssertTrue(markdownString.containsString(" Enumeration"))
        XCTAssertTrue(markdownString.containsString(" Declaration"))
        XCTAssertFalse(markdownString.containsString("%"))
    }
    
    func testClassMarkdownWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let markdownString = MarkdownGenerator.classesMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(markdownString.containsString(" TestName"))
        XCTAssertTrue(markdownString.containsString(" Class"))
        
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.enumerations))
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.properties))
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.methods))
    }
    
    func testStructureMarkdownWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let markdownString = MarkdownGenerator.structuresMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(markdownString.containsString(" TestName"))
        XCTAssertTrue(markdownString.containsString(" Structure"))
        
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.enumerations))
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.properties))
        XCTAssertTrue(markdownString.containsString(ReplaceTarget.ClassesAndStructures.methods))
    }
    
    func testMemberPropertyMarkdownWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let memberProperty = MarkdownGenerator.memberPropertyMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(memberProperty.containsString("`TestName`"))
        XCTAssertTrue(memberProperty.containsString("This is a test comment."))
        XCTAssertTrue(memberProperty.containsString(" Declaration"))
        XCTAssertTrue(memberProperty.containsString("TestDec"))
        XCTAssertFalse(memberProperty.containsString("%"))
        XCTAssertFalse(memberProperty.containsString("{% name %}"))
        XCTAssertFalse(memberProperty.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(memberProperty.containsString("{% MemberDeclaration.md %}"))
    }
    
    func testMemberMethodMarkdownWithSwiftObject() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: "TestKind",
            name: "TestName",
            parsed_declaration: "TestDec",
            doc_comment: "This is a test comment.\n- seealso:\n  The Swift Standard Library Reference",
            parameters: [DocParameters(name: "TestParameter", discussion: [Discussion(para: "TestDiscussion")])],
            result_discussion: [Discussion(para: "TestResultDiscussion")],
            substructure: nil
        )
        let methodMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(methodMarkdownString.containsString(" Declaration"))
        XCTAssertTrue(methodMarkdownString.containsString("TestDec"))
        XCTAssertTrue(methodMarkdownString.containsString("This is a test comment."))
        XCTAssertTrue(methodMarkdownString.containsString(" Parameters"))
        XCTAssertTrue(methodMarkdownString.containsString("TestParameter"))
        XCTAssertTrue(methodMarkdownString.containsString("TestDiscussion"))
        XCTAssertTrue(methodMarkdownString.containsString(" Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("TestResultDiscussion"))
        XCTAssertTrue(methodMarkdownString.containsString(" See Also"))
        XCTAssertTrue(methodMarkdownString.containsString("The Swift Standard Library Reference"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberSeeAlso.md %}"))
    }
    
    func testMethodMarkdownWithNameAndDocComment() {
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
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.containsString("TestName"))
        XCTAssertTrue(commentMarkdownString.containsString("This is a test comment."))
        XCTAssertFalse(commentMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(commentMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(commentMarkdownString.containsString(" See Also"))
    }
    
    func testMethodMarkdowntWithNoNameAndAccessibility() {
        let swiftObject = SwiftObject(
            accessibility: "TestAccessibility",
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: nil,
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.isEmpty, "No Name.")
    }
    
    func testMethodMarkdowntWithNoNameAndKind() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: "TestKind",
            name: nil,
            parsed_declaration: nil,
            doc_comment: nil,
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.isEmpty, "No Name.")
    }
    
    func testMethodMarkdowntWithNoNameAndParsedDeclaration() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: "TestParsedDeclaration",
            doc_comment: nil,
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.isEmpty, "No Name.")
    }
    
    func testMethodMarkdowntWithNoNameAndDocComment() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: "TestDocComment",
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.isEmpty, "No Name.")
    }
    
    func testMethodMarkdowntWithNoNameAndParameters() {
        let docParameter = DocParameters(name: "TestParameter", discussion: [Discussion(para: "p1")])
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: nil,
            parameters: [docParameter],
            result_discussion: nil,
            substructure: nil
        )
        let commentMarkdownString = MarkdownGenerator.memberMethodMarkdownWithSwiftObject(swiftObject)
        XCTAssertTrue(commentMarkdownString.isEmpty, "No Name.")
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
        let resuleReturnValueString = MarkdownGenerator.memberReturnValueMarkdownString(swiftObject)
        XCTAssertTrue(resuleReturnValueString.containsString(" Return Value"))
        XCTAssertTrue(resuleReturnValueString.containsString("testReturnValue"))
        XCTAssertFalse(resuleReturnValueString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(resuleReturnValueString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(resuleReturnValueString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(resuleReturnValueString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertFalse(resuleReturnValueString.containsString("{% MemberSeeAlso.md %}"))
    }
    
    func testMethodMarkdownStringReturnValue() {
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
        var methodMarkdownString = TemplateType.MemberMethod.markdownStringWithTargetString(ReplaceTarget.name, withString: "TestName")
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberDocComment.md %}", withString: MarkdownGenerator.memberDocCommentMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberDeclaration.md %}", withString: MarkdownGenerator.memberDeclarationMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberParameters.md %}", withString: MarkdownGenerator.memberParametersMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberReturnValue.md %}", withString: MarkdownGenerator.memberReturnValueMarkdownString(swiftObject))
        XCTAssertTrue(methodMarkdownString.containsString(" Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("testReturnValue"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberSeeAlso.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberSeeAlso.md %}", withString: MarkdownGenerator.memberSeeAlsoMarkdownString(swiftObject))
        XCTAssertTrue(methodMarkdownString.containsString(" Return Value"))
        XCTAssertTrue(methodMarkdownString.containsString("testReturnValue"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberSeeAlso.md %}"))
    }
    
    func testSeeAlsoString() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: "- seealso:\n  The Swift Standard Library Reference",
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        let seeAlsoString = MarkdownGenerator.memberSeeAlsoMarkdownString(swiftObject)
        XCTAssertTrue(seeAlsoString.containsString(" See Also"))
        XCTAssertTrue(seeAlsoString.containsString("The Swift Standard Library Reference"))
        XCTAssertFalse(seeAlsoString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(seeAlsoString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(seeAlsoString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(seeAlsoString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertFalse(seeAlsoString.containsString("{% MemberSeeAlso.md %}"))
    }
    
    func testMethodMarkdownStringSeeAlso() {
        let swiftObject = SwiftObject(
            accessibility: nil,
            kind: nil,
            name: nil,
            parsed_declaration: nil,
            doc_comment: "- seealso:\n  The Swift Standard Library Reference",
            parameters: nil,
            result_discussion: nil,
            substructure: nil
        )
        var methodMarkdownString = TemplateType.MemberMethod.markdownStringWithTargetString(ReplaceTarget.name, withString: "TestName")
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberDocComment.md %}", withString: MarkdownGenerator.memberDocCommentMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberDeclaration.md %}", withString: MarkdownGenerator.memberDeclarationMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberParameters.md %}", withString: MarkdownGenerator.memberParametersMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Return Value"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberReturnValue.md %}", withString: MarkdownGenerator.memberReturnValueMarkdownString(swiftObject))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" See Also"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        
        XCTAssertTrue(methodMarkdownString.containsString("{% MemberSeeAlso.md %}"))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("{% MemberSeeAlso.md %}", withString: MarkdownGenerator.memberSeeAlsoMarkdownString(swiftObject))
        XCTAssertTrue(methodMarkdownString.containsString(" See Also"))
        
        XCTAssertTrue(methodMarkdownString.containsString("The Swift Standard Library Reference"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Declaration"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString(" Parameters"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertFalse(methodMarkdownString.containsString("{% MemberSeeAlso.md %}"))
    }
}
