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
    static let classTemplate = MarkdownTemplate(fileName: "Class.md").markdownString
    static let propertiesTemplate = MarkdownTemplate(fileName: "Properties.md").markdownString
    static let methodsTemplate = MarkdownTemplate(fileName: "Methods.md").markdownString
    static let c_propertyTemplate = MarkdownTemplate(fileName: "ClassProperty.md").markdownString
    static let c_methodTemplate = MarkdownTemplate(fileName: "ClassMethod.md").markdownString
    static let c_commentTemplate = MarkdownTemplate(fileName: "ClassComment.md").markdownString
    static let c_DeclarationTemplate = MarkdownTemplate(fileName: "ClassDeclaration.md").markdownString
    static let c_parametersTemplate = MarkdownTemplate(fileName: "ClassParameters.md").markdownString
    static let c_parameterTemplate = MarkdownTemplate(fileName: "ClassParameter.md").markdownString
    static let c_returnValueTemplate = MarkdownTemplate(fileName: "ClassReturnValue.md").markdownString
    static let c_seeAlsoTemplate = MarkdownTemplate(fileName: "ClassSeeAlso.md").markdownString
    static let enumTemplate = MarkdownTemplate(fileName: "Enumeration.md").markdownString
    static let enumDeclarationTemplate = MarkdownTemplate(fileName: "EnumerationDeclaration.md").markdownString
    
    // MARK: - Enumerations
    
    static func enumMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name, parsed_declaration = swiftObject.parsed_declaration else {
            return ""
        }
        
        let enumMarkdownString = enumTemplate.stringByReplacingOccurrencesOfString("%name%", withString: name)
        
        var enumDeclaration = parsed_declaration + " {"
        if let enumCases = swiftObject.substructure {
            _ = enumCases.map {
                if let enumElements = $0.substructure {
                    _ = enumElements.map {
                        if let parsed_declaration = $0.parsed_declaration {
                            enumDeclaration += "\n    " + parsed_declaration
                        }
                    }
                }
            }
            enumDeclaration = enumDeclaration + "\n}"
        }
        
        let enumDeclarationMarkdownString = enumDeclarationTemplate.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: enumDeclaration)
        
        return enumMarkdownString.stringByReplacingOccurrencesOfString("%Declaration.md%", withString: enumDeclarationMarkdownString)
    }
    
    // MARK: - Classes
    
    static func classMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        return classTemplate.stringByReplacingOccurrencesOfString("%name%", withString: name)
    }
    
    static func classMethodMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        var methodMarkdownString = c_methodTemplate.stringByReplacingOccurrencesOfString("%name%", withString: name)
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassComment.md%", withString: classCommentMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassDeclaration.md%", withString: classDeclarationMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassParameters.md%", withString: classParametersMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassReturnValue.md%", withString: classReturnValueMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ClassSeeAlso.md%", withString: classSeeAlsoMarkdownString(swiftObject))
        
        return methodMarkdownString
    }
    
    static func classPropertyMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard let name = swiftObject.name else {
            return ""
        }
        
        var propertyMarkdownString = c_propertyTemplate.stringByReplacingOccurrencesOfString("%name%", withString: name)
        propertyMarkdownString = propertyMarkdownString.stringByReplacingOccurrencesOfString("%ClassComment.md%", withString: classCommentMarkdownString(swiftObject))
        propertyMarkdownString = propertyMarkdownString.stringByReplacingOccurrencesOfString("%ClassDeclaration.md%", withString: classDeclarationMarkdownString(swiftObject))
        
        return propertyMarkdownString
    }
    
    // MARK: - If invalid, return empty string.
    
    static func classCommentMarkdownString(swiftObject: SwiftObject) -> String {
        if let doc_comment = swiftObject.doc_comment {
            return c_commentTemplate.stringByReplacingOccurrencesOfString("%doc_comment%", withString: doc_comment)
        } else {
            return ""
        }
    }
    
    static func classDeclarationMarkdownString(swiftObject: SwiftObject) -> String {
        if let parsed_declaration = swiftObject.parsed_declaration {
            return c_DeclarationTemplate.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: parsed_declaration)
        } else {
            return ""
        }
    }
    
    // MARK: - doc
    
    static func classParametersMarkdownString(swiftObject: SwiftObject) -> String {
        guard let parameters = swiftObject.parameters else {
            return ""
        }
        
        var parametersString = ""
        _ = parameters.map {
            if let name = $0.name {
                var parameter = c_parameterTemplate.stringByReplacingOccurrencesOfString("%parameter_name%", withString: name)
                if let discussion = $0.discussion {
                    _ = discussion.map {
                        let para = $0.para ?? ""
                        parameter = parameter.stringByReplacingOccurrencesOfString("%parameter_description%", withString: para)
                    }
                }
                parametersString += parameter
            }
        }
        
        return c_parametersTemplate.stringByReplacingOccurrencesOfString("%parameters%", withString: parametersString)
    }
    
    static func classReturnValueMarkdownString(swiftObject: SwiftObject) -> String {
        guard let result_discussion = swiftObject.result_discussion else {
            return ""
        }
        
        var returnValueString = ""
        _ = result_discussion.map {
            if let para = $0.para {
               returnValueString += para
            }
        }
        
        return c_returnValueTemplate.stringByReplacingOccurrencesOfString("%result_discussion%", withString: returnValueString)
    }
    
    static func classSeeAlsoMarkdownString(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    // MARK: -
    
    static func outputMarkdown() {
        _ = SwiftDocsParser.swiftObjects.map {
            if let swiftObject = $0.substructure {
                _ = swiftObject.map {
                    writeMarkdownFile($0)
                }
            }
        }
    }
    
    static func writeMarkdownFile(swiftObject: SwiftObject) {
        guard let name = swiftObject.name, kind = swiftObject.kind, swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) else {
            return
        }
        
        var moduleString = ""
        switch swiftDeclarationKind {
        case .Class:
            moduleString = classMarkdownWithSwiftObject(swiftObject)
        case .Enum:
            moduleString = enumMarkdownStringWithSwiftObject(swiftObject)
        default:
            return
        }
        
        var enumerationsString = ""
        var propertiesString = ""
        var methodsString = ""
        _ = swiftObject.substructure?.map {
            if swiftObject.kind == SwiftDeclarationKind.Class.rawValue {
                if let kind = $0.kind, swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                    switch swiftDeclarationKind {
                    case .VarInstance:
                        propertiesString += classPropertyMarkdownWithSwiftObject($0)
                    case .FunctionMethodClass, .FunctionMethodInstance, .FunctionMethodStatic:
                        methodsString += classMethodMarkdownWithSwiftObject($0)
                    default:
                        break
                    }
                }
            }
        }
        
        moduleString = moduleString.stringByReplacingOccurrencesOfString("%Enumerations%", withString: enumerationsString)
        
        let p = propertiesTemplate.stringByReplacingOccurrencesOfString("%ClassProperties%", withString: propertiesString)
        moduleString = moduleString.stringByReplacingOccurrencesOfString("%Properties%", withString: p)
        
        let m = methodsTemplate.stringByReplacingOccurrencesOfString("%ClassMethods%", withString: methodsString)
        moduleString = moduleString.stringByReplacingOccurrencesOfString("%Methods%", withString: m)
        
        let filePath = outPath + "/" + name + ".md"
        WriteToFile.writeToFileWithString(moduleString, filePath: filePath)
    }
}
