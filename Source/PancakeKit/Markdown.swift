//
//  Markdown.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

final class Markdown {
    static let outPath = NSHomeDirectory() + "/Pancake/DemoApp/Documentation"
    
    // MARK: - source.lang.swift.decl.var.global
    
    static func varGlobalMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name, parsed_declaration = swiftObject.parsed_declaration else {
            return ""
        }
        
        let memberDeclaration = TemplateType.MemberDeclaration.markdownStringWithTargetString(ReplaceTarget.parsed_declaration, withString: parsed_declaration)
        var memberProperties = TemplateType.MemberProperty.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        memberProperties = memberProperties.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.docComment, withString: "")
        memberProperties = memberProperties.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.declaration, withString: memberDeclaration)
        
        let globalMarkdownString = TemplateType.Global.markdownStringWithTargetString(ReplaceTarget.Member.properties, withString: memberProperties)
        
        return globalMarkdownString
    }
    
    // MARK: - Top Level
    
    static func enumMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name, parsed_declaration = swiftObject.parsed_declaration else {
            return ""
        }
        
        let enumMarkdownString = TemplateType.Enum.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        
        var enumDeclaration = parsed_declaration + " {"
        if let enumCases = swiftObject.substructure {
            enumCases.forEach {
                if let enumElements = $0.substructure {
                    enumElements.forEach {
                        if let parsed_declaration = $0.parsed_declaration {
                            enumDeclaration += "\n    " + parsed_declaration
                        }
                    }
                }
            }
            enumDeclaration = enumDeclaration + "\n}"
        }
        
        let enumDeclarationMarkdownString = TemplateType.Declaration.markdownStringWithTargetString(ReplaceTarget.parsed_declaration, withString: enumDeclaration)
        
        return enumMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.declaration, withString: enumDeclarationMarkdownString)
    }
    
    // MARK: - Classes And Structures
    
    ///- attention: If invalid, return empty string.
    static func classesAndStructuresMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        return TemplateType.ClassesAndStructures.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
    }
    
    static func memberMethodMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        var methodMarkdownString = TemplateType.MemberMethod.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.docComment, withString: memberDocCommentMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.declaration, withString: memberDeclarationMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.parameters, withString: memberParametersMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.returnValue, withString: memberReturnValueMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.seeAlso, withString: memberSeeAlsoMarkdownString(swiftObject))
        
        return methodMarkdownString
    }
    
    static func memberPropertyMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        var propertyMarkdownString = TemplateType.MemberProperty.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        propertyMarkdownString = propertyMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.docComment, withString: memberDocCommentMarkdownString(swiftObject))
        propertyMarkdownString = propertyMarkdownString.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.declaration, withString: memberDeclarationMarkdownString(swiftObject))
        
        return propertyMarkdownString
    }
    
    static func memberDocCommentMarkdownString(swiftObject: SwiftObject) -> String {
        if let doc_comment = swiftObject.doc_comment {
            return TemplateType.MemberDocComment.markdownStringWithTargetString(ReplaceTarget.doc_comment, withString: doc_comment)
        } else {
            return ""
        }
    }
    
    static func memberDeclarationMarkdownString(swiftObject: SwiftObject) -> String {
        if let parsed_declaration = swiftObject.parsed_declaration {
            return TemplateType.MemberDeclaration.markdownStringWithTargetString(ReplaceTarget.parsed_declaration, withString: parsed_declaration)
        } else {
            return ""
        }
    }
    
    static func memberParametersMarkdownString(swiftObject: SwiftObject) -> String {
        guard let parameters = swiftObject.parameters else {
            return ""
        }
        
        var parametersString = ""
        parameters.forEach {
            if let name = $0.name {
                var parameter = TemplateType.MemberParameter.markdownStringWithTargetString(ReplaceTarget.Parameter.name, withString: name)
                if let discussion = $0.discussion {
                    discussion.forEach {
                        let para = $0.para ?? ""
                        parameter = parameter.stringByReplacingOccurrencesOfString(ReplaceTarget.Parameter.description, withString: para)
                    }
                }
                parametersString += parameter
            }
        }
        
        return TemplateType.MemberParameters.markdownStringWithTargetString(ReplaceTarget.parameters, withString: parametersString)
    }
    
    static func memberReturnValueMarkdownString(swiftObject: SwiftObject) -> String {
        guard let result_discussion = swiftObject.result_discussion else {
            return ""
        }
        
        var returnValueString = ""
        result_discussion.forEach {
            if let para = $0.para {
               returnValueString += para
            }
        }
        
        return TemplateType.MemberReturnValue.markdownStringWithTargetString(ReplaceTarget.result_discussion, withString: returnValueString)
    }
    
    /// key.doc.comment
    static func memberSeeAlsoMarkdownString(swiftObject: SwiftObject) -> String {
        let targetString = ReplaceTarget.DocComment.seeAlso
        guard let doc_comment = swiftObject.doc_comment where doc_comment.containsString(targetString) else {
            return ""
        }
        
        let scanner = NSScanner(string: doc_comment)
        scanner.scanUpToString(targetString, intoString: nil)  // false
        scanner.scanLocation += targetString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        var scanNSString: NSString?
        guard scanner.scanUpToString(",", intoString: &scanNSString),
            let scanString = scanNSString as? String else {
            return ""
        }
        
        return TemplateType.MemberSeeAlso.markdownStringWithTargetString(ReplaceTarget.see_also, withString: scanString)
    }
    
    // MARK: -
    
    static func outputMarkdown() {
        SwiftDocsParser.swiftObjects.forEach {
            if let swiftObjects = $0.substructure {
                print("swiftObjects.count: \(swiftObjects.count)")
                swiftObjects.forEach {
                    writeMarkdownFile($0)
                }
            }
        }
    }
    
    static func writeMarkdownFile(swiftObject: SwiftObject) {
        guard var name = swiftObject.name,
            let kind = swiftObject.kind,
            swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) else {
            return
        }
        
        var moduleString = ""
        switch swiftDeclarationKind {
        case .VarGlobal:
            moduleString = varGlobalMarkdownStringWithSwiftObject(swiftObject)
        case .Class, .Struct:
            moduleString = classesAndStructuresMarkdownWithSwiftObject(swiftObject)
        case .Enum:
            moduleString = enumMarkdownStringWithSwiftObject(swiftObject)
        default:
            return
        }
        
        var enumerationsString = ""
        var propertiesString = ""
        var methodsString = ""
        _ = swiftObject.substructure?.map {
            if swiftObject.kind == SwiftDeclarationKind.Class.rawValue
            || swiftObject.kind == SwiftDeclarationKind.Struct.rawValue {
                if let kind = $0.kind, swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                    switch swiftDeclarationKind {
                    case .VarInstance:
                        propertiesString += memberPropertyMarkdownWithSwiftObject($0)
                    case .FunctionMethodClass, .FunctionMethodInstance, .FunctionMethodStatic:
                        methodsString += memberMethodMarkdownWithSwiftObject($0)
                    default:
                        break
                    }
                }
            }
        }
        
        if methodsString.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: "")
        } else {
            let m = TemplateType.Methods.markdownStringWithTargetString(ReplaceTarget.Member.methods, withString: methodsString)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: m)
        }
        
        // MARK: -
    
        if enumerationsString.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: "")
        } else {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: enumerationsString)
        }
        
        if propertiesString.isEmpty {
                moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: "")
        } else {
            let p = TemplateType.Properties.markdownStringWithTargetString(ReplaceTarget.Member.properties, withString: propertiesString)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: p)
        }
        
        switch swiftDeclarationKind {
        case .VarGlobal:
            name = "Global"
        case .Enum:
            name += "Enumeration"
        case .Class:
            name += "Class"
        case .Struct:
            name += "Structure"
        default:
            break
        }
        name += "Reference"
        
        let filePath = outPath + "/" + name + ".md"
        WriteToFile.writeToFileWithString(moduleString, filePath: filePath)
    }
}
