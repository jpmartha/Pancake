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
    
    // MARK: - Global
    
    static func globalMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name, parsed_declaration = swiftObject.parsed_declaration else {
            return ""
        }
        
        var globalVariable = TemplateType.GlobalVariable.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        
        if let doc_comment = swiftObject.doc_comment {
            let comment = TemplateType.GlobalDocComment.markdownStringWithTargetString(ReplaceTarget.doc_comment, withString: doc_comment)
            globalVariable = globalVariable.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.doc_comment, withString: comment)
        } else {
            globalVariable = globalVariable.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.doc_comment, withString: "")
        }
        
        let declaration = TemplateType.GlobalDeclaration.markdownStringWithTargetString(ReplaceTarget.parsed_declaration, withString: parsed_declaration)
        globalVariable = globalVariable.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.parsed_declaration, withString: declaration)
        
        return TemplateType.GlobalVariables.markdownStringWithTargetString(ReplaceTarget.Global.variables, withString: globalVariable)
    }
    
    static func globalEnumerationMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name, parsed_declaration = swiftObject.parsed_declaration else {
            return ""
        }
        
        var globalEnumeration = TemplateType.GlobalEnumerations.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        
        if let doc_comment = swiftObject.doc_comment {
            let comment = TemplateType.GlobalDocComment.markdownStringWithTargetString(ReplaceTarget.doc_comment, withString: doc_comment)
            globalEnumeration = globalEnumeration.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.doc_comment, withString: comment)
        } else {
            globalEnumeration = globalEnumeration.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.doc_comment, withString: "")
        }
        
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
        
        let declaration = TemplateType.GlobalDeclaration.markdownStringWithTargetString(ReplaceTarget.parsed_declaration, withString: enumDeclaration)
        
        return globalEnumeration.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.parsed_declaration, withString: declaration)
    }
    
    // MARK: - Classes And Structures
    
    ///- attention: If invalid, return empty string.
    static func classesMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        //{% Enumerations %}{% Properties %}{% Methods %}
        
        return TemplateType.Classes.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
    }
    
    static func structuresMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        return TemplateType.Structures.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
    }
    
    // MARK: - Member
    
    static func memberEnumerationMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        var memberEnumeration = TemplateType.MemberEnumeration.markdownStringWithTargetString(ReplaceTarget.name, withString: name)
        memberEnumeration = memberEnumeration.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.docComment, withString: memberDocCommentMarkdownString(swiftObject))
        memberEnumeration = memberEnumeration.stringByReplacingOccurrencesOfString(ReplaceTarget.Member.declaration, withString: memberDeclarationMarkdownString(swiftObject))
        
        return memberEnumeration
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
    
    // MARK: - Member Parts
    
    static func memberDocCommentMarkdownString(swiftObject: SwiftObject) -> String {
        if let doc_comment = swiftObject.doc_comment {
            let scanner = NSScanner(string: doc_comment)
            var comment: NSString?
            scanner.scanUpToString("\n", intoString: &comment)
            guard let commentString = comment as? String else {
                return ""
            }
            
            return TemplateType.MemberDocComment.markdownStringWithTargetString(ReplaceTarget.doc_comment, withString: commentString)
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
    
    static func outputMarkdownWithOutPath(outPath: String) {
        CreateDocumentationDirectory.createDirectoryAtPath(outPath)
        
        SwiftDocsParser.swiftObjects.forEach {
            if let swiftObjects = $0.substructure {
                //print("swiftObjects.count: \(swiftObjects.count)")
                swiftObjects.forEach {
                    writeMarkdownFile($0, outPath: outPath)
                }
            }
        }
    }
    
    static func writeMarkdownFile(swiftObject: SwiftObject, outPath: String) {
        guard var name = swiftObject.name,
            let kind = swiftObject.kind,
            swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) else {
            return
        }
        
        var moduleString = ""
        switch swiftDeclarationKind {
        case .VarGlobal:
            moduleString = globalMarkdownStringWithSwiftObject(swiftObject)
        case .Class:
            moduleString = classesMarkdownWithSwiftObject(swiftObject)
        case .Struct:
            moduleString = structuresMarkdownWithSwiftObject(swiftObject)
        case .Enum:
            moduleString = globalEnumerationMarkdownStringWithSwiftObject(swiftObject)
        default:
            return
        }
        
        var enumerations = ""
        var properties = ""
        var methods = ""
        _ = swiftObject.substructure?.map {
            if swiftObject.kind == SwiftDeclarationKind.Class.rawValue
            || swiftObject.kind == SwiftDeclarationKind.Struct.rawValue {
                if let kind = $0.kind, swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                    switch swiftDeclarationKind {
                    case .VarInstance:
                        properties += memberPropertyMarkdownWithSwiftObject($0)
                    case .FunctionMethodClass, .FunctionMethodInstance, .FunctionMethodStatic:
                        methods += memberMethodMarkdownWithSwiftObject($0)
                    default:
                        break
                    }
                }
            }
        }
        
        // MARK: -
    
        if enumerations.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: "")
        } else {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: enumerations)
        }
        
        if properties.isEmpty {
                moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: "")
        } else {
            let p = TemplateType.Properties.markdownStringWithTargetString(ReplaceTarget.Member.properties, withString: properties)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: p)
        }
        
        if methods.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: "")
        } else {
            let m = TemplateType.Methods.markdownStringWithTargetString(ReplaceTarget.Member.methods, withString: methods)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: m)
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
        
        let filename = name + ".md"
        print("Generating \(filename)")
        let filePath = outPath + "/" + filename
        WriteToFile.writeToFileWithString(moduleString, filePath: filePath)
    }
}
