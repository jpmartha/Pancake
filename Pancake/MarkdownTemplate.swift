//
//  MarkdownTemplate.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

struct MarkdownTemplate {
    let fileDirectory = NSHomeDirectory() + "/Pancake/Templates"
    let markdownString: String
    
    init(fileName: String) {
        let filePath = fileDirectory + "/" + fileName
        do {
            self.markdownString = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            self.markdownString = ""
        }
    }
}

enum TemplateType: String {
    case Global = "Global.md"
    case Enum = "Enumerations.md"
    case Declaration = "Declaration.md"
    case ClassesAndStructures = "ClassesAndStructures.md"
    case Properties = "Properties.md"
    case Methods = "Methods.md"
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
    static let declaration = "{% Declaration.md %}" // FIXME: まぎらわしい
    
    static let name = "{% name %}"
    static let doc_comment = "{% doc_comment %}"
    static let parsed_declaration = "{% parsed_declaration %}" // FIXME: まぎらわしい
    static let parameters = "{% parameters %}"
    static let result_discussion = "{% result_discussion %}"
    static let see_also = "{% see_also %}"
    
    struct ClassesAndStructures {
        static let enumerations = "{% Enumerations %}"
        static let properties = "{% Properties %}"
        static let methods = "{% Methods %}"
    }

    struct Member {
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
