//
//  Markdown.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

class Markdown {
    static let outPath = NSHomeDirectory() + "/Pancake/DemoApp/Documentation"
    static let classTemplate = MarkdownTemplate(fileName: "Class.md")?.markdownString
    static let methodTemplate = MarkdownTemplate(fileName: "Method.md")?.markdownString
    static let commentTemplate = MarkdownTemplate(fileName: "Comment.md")?.markdownString
    static let declarationTemplate = MarkdownTemplate(fileName: "Declaration.md")?.markdownString
    static let parametersTemplate = MarkdownTemplate(fileName: "Parameters.md")?.markdownString
    static let parameterTemplate = MarkdownTemplate(fileName: "Parameter.md")?.markdownString
    static let returnValueTemplate = MarkdownTemplate(fileName: "ReturnValue.md")?.markdownString
    static let seeAlsoTemplate = MarkdownTemplate(fileName: "SeeAlso.md")?.markdownString
    static let enumTemplate = MarkdownTemplate(fileName: "Enumeration.md")?.markdownString
    static let enumDeclarationTemplate = MarkdownTemplate(fileName: "EnumerationDeclaration.md")?.markdownString
    
    static func classMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String? {
        guard let classMarkdownString = classTemplate else {
            return nil
        }
        guard let name = swiftObject.name else {
            return nil
        }
        return classMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: name)
    }
    
    static func methodMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard var methodMarkdownString = methodTemplate else {
            return ""
        }
        guard let name = swiftObject.name else {
            return ""
        }
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: name)
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Comment.md%", withString: commentMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Declaration.md%", withString: declarationMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Parameters.md%", withString: parametersMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ReturnValue.md%", withString: returnValueMarkdownString(swiftObject))
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%SeeAlso.md%", withString: seeAlsoMarkdownString(swiftObject))
        
        return methodMarkdownString
    }
    
    static func enumMarkdownStringWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard var enumMarkdownString = enumTemplate else {
            print("EnumerationMarkdownString Error")
            return ""
        }
        guard var enumDeclarationMarkdownString = enumDeclarationTemplate else {
            print("DeclarationMarkdownString Error")
            return ""
        }
        guard let name = swiftObject.name else {
            print("Name Error")
            return ""
        }
        guard let parsed_declaration = swiftObject.parsed_declaration else {
            print("Parsed Declaration Error")
            return ""
        }
        
        enumMarkdownString = enumMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: name)
        
        var enumDeclaration = parsed_declaration + " {"
        if let enumCases = swiftObject.substructure {
            _ = enumCases.map {
                if let enumElements = $0.substructure {
                    _ = enumElements.map {
                        if let parsed_declaration = $0.parsed_declaration {
                            enumDeclaration = enumDeclaration + "\n    " + parsed_declaration
                        }
                    }
                }
            }
            enumDeclaration = enumDeclaration + "\n}"
        }
        
        enumDeclarationMarkdownString = enumDeclarationMarkdownString.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: enumDeclaration)
        
        return enumMarkdownString.stringByReplacingOccurrencesOfString("%Declaration.md%", withString: enumDeclarationMarkdownString)
    }
    
    // MARK: - If invalid, return empty string.
    
    static func commentMarkdownString(swiftObject: SwiftObject) -> String {
        guard let commentMarkdownString = commentTemplate else {
            return ""
        }
        
        if let doc_comment = swiftObject.doc_comment {
            return commentMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: doc_comment)
        } else {
            return ""
        }
    }
    
    static func declarationMarkdownString(swiftObject: SwiftObject) -> String {
        guard let declarationMarkdownString = declarationTemplate else {
            return ""
        }
        
        if let parsed_declaration = swiftObject.parsed_declaration {
            return declarationMarkdownString.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: parsed_declaration)
        } else {
            return ""
        }
    }
    
    static func parametersMarkdownString(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    static func returnValueMarkdownString(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    static func seeAlsoMarkdownString(swiftObject: SwiftObject) -> String {
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
        var moduleString: String?
        if let kind = swiftObject.kind {
            if let swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                switch swiftDeclarationKind {
                case .Class:
                    if let classMarkdown = classMarkdownWithSwiftObject(swiftObject) {
                        moduleString = classMarkdown
                    }
                case .Enum:
                    moduleString = enumMarkdownStringWithSwiftObject(swiftObject)
                    print("Enumeration: \(moduleString)")
                default:
                    break
                }
            }
        }
        
        _ = swiftObject.substructure?.map {
            if let kind = swiftObject.kind {
                if let swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                    switch swiftDeclarationKind {
                    case .Class:
                        if let string = moduleString {
                            moduleString = string + methodMarkdownWithSwiftObject($0)
                        }
                    default:
                        break
                    }
                }
            }
        }

        guard let string = moduleString else {
            return
        }
        guard let name = swiftObject.name else {
            return
        }
        
        let filePath = outPath + "/" + name + ".md"
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
        print(filePath)
    }
}
