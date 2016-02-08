//
//  MarkdownTemplateTests.swift
//  PancakeTests
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import XCTest
@testable import PancakeKit

class TemplateTests: XCTestCase {
    func testClassTemplate() {
        let template = MarkdownTemplate(fileName: "ClassesAndStructures.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("{% name %}"))
        XCTAssertTrue(template.markdownString.containsString("Methods"))
    }
    
    func testMethodsTemplate() {
        let template = MarkdownTemplate(fileName: "MemberMethod.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("`{% name %}`"))
        XCTAssertTrue(template.markdownString.containsString("{% MemberDocComment.md %}"))
        XCTAssertTrue(template.markdownString.containsString("{% MemberDeclaration.md %}"))
        XCTAssertTrue(template.markdownString.containsString("{% MemberParameters.md %}"))
        XCTAssertTrue(template.markdownString.containsString("{% MemberReturnValue.md %}"))
        XCTAssertTrue(template.markdownString.containsString("{% MemberSeeAlso.md %}"))
    }
    
    func testCommentTemplate() {
        let template = MarkdownTemplate(fileName: "MemberDocComment.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("{% doc_comment %}"))
    }
    
    func testMethodDeclarationTemplate() {
        let template = MarkdownTemplate(fileName: "MemberDeclaration.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Declaration"))
        XCTAssertTrue(template.markdownString.containsString("```swift\n  {% parsed_declaration %}\n  ```"))
    }
    
    func testParametersTemplate() {
        let template = MarkdownTemplate(fileName: "MemberParameters.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Parameters"))
        XCTAssertTrue(template.markdownString.containsString("{% parameters %}"))
    }
    
    func testParameterTemplate() {
        let template = MarkdownTemplate(fileName: "MemberParameter.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("{% parameter_name %}"))
        XCTAssertTrue(template.markdownString.containsString("{% parameter_description %}"))
    }
    
    func testReturnValueTemplate() {
        let template = MarkdownTemplate(fileName: "MemberReturnValue.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("Return Value"))
        XCTAssertTrue(template.markdownString.containsString("{% result_discussion %}"))
    }
    
    func testSeeAlsoTemplate() {
        let template = MarkdownTemplate(fileName: "MemberSeeAlso.md")
        XCTAssertNotNil(template)
        XCTAssertTrue(template.markdownString.containsString("See Also"))
        XCTAssertTrue(template.markdownString.containsString("{% see_also %}"))
    }
    
    func testEnumTemplate() {
        let template = MarkdownTemplate(fileName: "Enumerations.md")
        XCTAssertNotNil(template)
    }
    
    func testEnumDeclarationTemplate() {
        let template = MarkdownTemplate(fileName: "Declaration.md")
        XCTAssertNotNil(template)
    }
    
    func testMarkdownStringWithTemplateTypeMemberProperty() {
        let markdownString = TemplateType.MemberProperty.markdownStringWithTargetString(ReplaceTarget.name, withString: "TestName")
        XCTAssertTrue(markdownString.containsString("TestName"))
    }
    
    func testMarkdownStringWithTemplateTypeMemberMethod() {
        let markdownString = TemplateType.MemberMethod.markdownStringWithTargetString(ReplaceTarget.name, withString: "TestName")
        XCTAssertTrue(markdownString.containsString("TestName"))
    }
    
    func testMarkdownStringWithTemplateTypeMemberDocComment() {
        let markdownString = TemplateType.MemberDocComment.markdownStringWithTargetString(ReplaceTarget.doc_comment, withString: "TestComment")
        XCTAssertTrue(markdownString.containsString("TestComment"))
    }
    
    func testReplaceTarget() {
        XCTAssertEqual(ReplaceTarget.declaration, "{% Declaration.md %}")
        XCTAssertEqual(ReplaceTarget.name, "{% name %}")
        XCTAssertEqual(ReplaceTarget.doc_comment, "{% doc_comment %}")
        XCTAssertEqual(ReplaceTarget.parsed_declaration, "{% parsed_declaration %}")
        XCTAssertEqual(ReplaceTarget.parameters, "{% parameters %}")
        XCTAssertEqual(ReplaceTarget.result_discussion, "{% result_discussion %}")
        XCTAssertEqual(ReplaceTarget.see_also, "{% see_also %}")
        XCTAssertEqual(ReplaceTarget.ClassesAndStructures.enumerations, "{% Enumerations %}")
        XCTAssertEqual(ReplaceTarget.ClassesAndStructures.properties, "{% Properties %}")
        XCTAssertEqual(ReplaceTarget.ClassesAndStructures.methods, "{% Methods %}")
        XCTAssertEqual(ReplaceTarget.Member.properties, "{% MemberProperties %}")
        XCTAssertEqual(ReplaceTarget.Member.methods, "{% MemberMethods %}")
        XCTAssertEqual(ReplaceTarget.Member.docComment, "{% MemberDocComment.md %}")
        XCTAssertEqual(ReplaceTarget.Member.declaration, "{% MemberDeclaration.md %}")
        XCTAssertEqual(ReplaceTarget.Member.parameters, "{% MemberParameters.md %}")
        XCTAssertEqual(ReplaceTarget.Member.returnValue, "{% MemberReturnValue.md %}")
        XCTAssertEqual(ReplaceTarget.Member.seeAlso, "{% MemberSeeAlso.md %}")
        XCTAssertEqual(ReplaceTarget.Parameter.name, "{% parameter_name %}")
        XCTAssertEqual(ReplaceTarget.Parameter.description, "{% parameter_description %}")
        XCTAssertEqual(ReplaceTarget.DocComment.seeAlso, "- seealso:")
    }
}
