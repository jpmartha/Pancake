//
//  MarkdownTemplate.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

struct MarkdownTemplate {
    let fileDirectory = NSHomeDirectory() + "/Pancake/Template"
    let markdownString: String
    
    init(fileName: String) {
        let filePath = fileDirectory + "/" + fileName
        do {
            markdownString = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            markdownString = ""
        }
    }
}

enum TemplateType: String {
    case GlobalVariables = "GlobalVariables.md"
    case GlobalVariable = "GlobalVariable.md"
    case GlobalDocComment = "GlobalDocComment.md"
    case GlobalEnumerations = "GlobalEnumerations.md"
    case GlobalDeclaration = "GlobalDeclaration.md"
    case Classes = "Classes.md"
    case Structures = "Structures.md"
    case Enumerations = "Enumerations.md"
    case Properties = "Properties.md"
    case Methods = "Methods.md"
    case MemberEnumeration = "MemberEnumeration.md"
    case MemberProperty = "MemberProperty.md"
    case MemberMethod = "MemberMethod.md"
    case MemberDocComment = "MemberDocComment.md"
    case MemberDeclaration = "MemberDeclaration.md"
    case MemberParameters = "MemberParameters.md"
    case MemberParameter = "MemberParameter.md"
    case MemberReturnValue = "MemberReturnValue.md"
    case MemberSeeAlso = "MemberSeeAlso.md"
    
    func markdownString() -> String {
        return MarkdownTemplate(fileName: self.rawValue).markdownString
    }
    
    func markdownStringWithTargetString(targetString: String, withString: String) -> String {
        return self.markdownString().stringByReplacingOccurrencesOfString(targetString, withString: withString)
    }
}

struct ReplaceTarget {
    static let name = "{% name %}"
    static let doc_comment = "{% doc_comment %}"
    static let parsed_declaration = "{% parsed_declaration %}"
    static let parameters = "{% parameters %}"
    static let result_discussion = "{% result_discussion %}"
    static let see_also = "{% see_also %}"
    
    struct Global {
        static let variables = "{% GlobalVariables %}"
        static let doc_comment = "{% GlobalDocComment.md %}"
        static let parsed_declaration = "{% GlobalDeclaration.md %}"
    }
    
    struct ClassesAndStructures {
        static let enumerations = "{% Enumerations %}"
        static let properties = "{% Properties %}"
        static let methods = "{% Methods %}"
    }

    struct Member {
        static let enumerations = "{% MemberEnumerations %}"
        static let properties = "{% MemberProperties %}"
        static let methods = "{% MemberMethods %}"
        
        static let docComment = "{% MemberDocComment.md %}"
        static let declaration = "{% MemberDeclaration.md %}"
        static let parameters =  "{% MemberParameters.md %}"
        static let returnValue = "{% MemberReturnValue.md %}"
        static let seeAlso = "{% MemberSeeAlso.md %}"
    }
    
    struct Parameter {
        static let name = "{% parameter_name %}"
        static let description = "{% parameter_description %}"
    }
    
    struct DocComment {
        static let seeAlso = "- seealso:"
    }
}
